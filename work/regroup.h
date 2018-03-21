#ifndef __RE_GROUP_H__
#define __RE_GROUP_H__

#include <vector>
#include <list>
#include <map>
#include <set>

class LevelNode {
public:
    LevelNode(int lv);
    ~LevelNode();

    bool       SetParent(LevelNode *par);
    int        GetLevel() const;
    LevelNode *GetParent();

private:
    int        _level;
    LevelNode *_parent;
};

template<typename T>
class LevelNodeMgr {
public:
    LevelNodeMgr();
    ~LevelNodeMgr();

    bool InsertData(const std::list<T> &data);
    bool OutputNewGroup(std::vector<std::list<T>*> *ret);

private:
    LevelNode* CreateNode(T d);
    LevelNode* CreateNode(int lev, LevelNode *a, LevelNode *b);
    bool       UpdateNode(LevelNode *cur, T d);
    LevelNode* GetTop(T d);
    LevelNode* GetTop(LevelNode *bottom);
    LevelNode* MergeNode(LevelNode *pre, LevelNode *cur);
    bool       ConnectParent(LevelNode *child, LevelNode *parent);

    std::list<std::list<LevelNode*> >   _level_lines;
    std::map<T, LevelNode*>             _data_map_bottom;
    std::map<LevelNode*, std::list<T> > _top_map_data;
};

// ---------------------------------------------------------------------------------------

LevelNode::LevelNode(int lv)
    : _level(lv),
      _parent(NULL) {
}

LevelNode::~LevelNode() {
}

bool LevelNode::SetParent(LevelNode *par) {
    if (par == NULL) {
        return false;
    }
    _parent = par;
    return true;
}

int LevelNode::GetLevel() const {
    return _level;
}

LevelNode* LevelNode::GetParent() {
    return _parent;
}

// ---------------------------------------------------------------------------------------

template<typename T>
LevelNodeMgr<T>::LevelNodeMgr() {
}

template<typename T>
LevelNodeMgr<T>::~LevelNodeMgr() {
    for (std::list<std::list<LevelNode*> >::iterator itline = _level_lines.begin();
         itline != _level_lines.end(); ++itline) {
        for (std::list<LevelNode*>::iterator itnd = itline->begin();
             itnd != itline->end(); ++itnd) {
            delete *itnd;
            *itnd = NULL;
        }     
    }
}

template<typename T>
LevelNode* LevelNodeMgr<T>::CreateNode(T d) {
    LevelNode *cur = new LevelNode(0);
    _data_map_bottom.insert(std::pair<T, LevelNode*>(d, cur));

    if (_level_lines.empty()) {
        std::list<LevelNode*> bottom;
        bottom.push_back(cur);
        _level_lines.push_back(bottom);
    } else {
        std::list<LevelNode*> &bottom = _level_lines.front();
        bottom.push_back(cur);
    }

    return cur;
}

template<typename T>
LevelNode* LevelNodeMgr<T>::CreateNode(int lev, LevelNode *pre, LevelNode *cur) {
    LevelNode   *new_node = NULL;

    if (_level_lines.size() < lev || lev <= 0) {
        // error occur
        delete new_node;
        new_node = NULL;
        return NULL;
    } else if (_level_lines.size() == lev) {
        // create new level
        std::list<LevelNode*> line;
        new_node = new LevelNode(lev);
        line.push_back(new_node);
        _level_lines.push_back(line);
    } else {
        int i = 0;
        for (std::list<std::list<LevelNode*> >::iterator itline = _level_lines.begin();
             itline != _level_lines.end(); ++itline, ++i) {
            if (i == lev) {
                new_node = new LevelNode(lev);
                itline->push_back(new_node);
                break;
            }
        }
    }
    
    if (!ConnectParent(pre, new_node) || 
        !ConnectParent(cur, new_node)) {
        // TODO rollback
        return NULL;
    }

    return new_node;
}

template<typename T>
bool LevelNodeMgr<T>::UpdateNode(LevelNode *cur, T d) {
    _data_map_bottom.insert(std::pair<T, LevelNode*>(d, cur));
    return true;
}

template<typename T>
bool LevelNodeMgr<T>::ConnectParent(LevelNode *child, LevelNode *parent) {
    if (child->GetLevel() >= parent->GetLevel()) {
        return false;
    }
    
    if (child->SetParent(parent)) {
        return true;
    }

    return false;
}

template<typename T>
LevelNode* LevelNodeMgr<T>::GetTop(T d) {
    typename std::map<T, LevelNode*>::iterator itbot = _data_map_bottom.find(d);
    if (itbot == _data_map_bottom.end()) {
        return NULL;
    }
    return GetTop(itbot->second);
}

template<typename T>
LevelNode* LevelNodeMgr<T>::GetTop(LevelNode *bottom) {
    LevelNode *chd = bottom;
    LevelNode *par = NULL;
    while ((par = chd->GetParent()) != NULL) {
        chd = par;
    }
    return chd;
}

template<typename T>
LevelNode* LevelNodeMgr<T>::MergeNode(LevelNode *pre, LevelNode *cur) {
    if (pre == NULL || pre == cur) {
        return cur;
    }
    
    LevelNode *ret = NULL;
    int pre_lev = pre->GetLevel();
    int cur_lev = cur->GetLevel();

    if (pre_lev == cur_lev) {
        ret = CreateNode(pre_lev + 1, pre, cur);
    } else if (pre_lev > cur_lev) {
        if (!ConnectParent(cur, pre)) {
            return NULL;
        }
        ret = pre;
    } else {
        if (!ConnectParent(pre, cur)) {
            return NULL;
        }
        ret = cur;
    }

    return ret;
}

template<typename T>
bool LevelNodeMgr<T>::InsertData(const std::list<T> &data) {
    bool                                        has_create_new = false;
    typename std::map<T, LevelNode*>::iterator  itbot;
    LevelNode                                  *new_node = NULL;
    LevelNode                                  *pre = NULL;
    LevelNode                                  *cur = NULL;

    for (typename std::list<T>::const_iterator itorg = data.begin();
         itorg != data.end(); ++itorg) {

        // find failure means itorg belong to new node in bottom level
        itbot = _data_map_bottom.find(*itorg);
        if (itbot == _data_map_bottom.end()) {
            if (!has_create_new) {
                new_node = CreateNode(*itorg);
                has_create_new = true;
            } else {
                UpdateNode(new_node, *itorg);
            }
            cur = new_node;
        } else {
            cur = GetTop(*itorg);
        } 

        pre = MergeNode(pre, cur);
    }
    return true;
}

template<typename T>
bool LevelNodeMgr<T>::OutputNewGroup(std::vector<std::list<T>*> *ret) {
    std::list<T>            tmp_line;
    std::list<LevelNode*>  &top_line = _level_lines.back();
    int                     gp_num = top_line.size();
    int                     j = 0;

    LevelNode                                               *top;
    typename std::map<LevelNode*, std::list<T> >::iterator   ittop;
    for (typename std::map<T, LevelNode*>::iterator itorg = _data_map_bottom.begin();
         itorg != _data_map_bottom.end(); ++itorg) {
        top = GetTop(itorg->second);
        ittop = _top_map_data.find(top);
        if (ittop == _top_map_data.end()) {
            std::list<T> memb;
            memb.push_back(itorg->first);
            _top_map_data.insert(std::pair<LevelNode*, std::list<T> >(top, memb));
        } else {
            std::list<T> &memb = ittop->second;
            memb.push_back(itorg->first);
        }
    }

    ret->reserve(_top_map_data.size());
    for (ittop = _top_map_data.begin(); ittop != _top_map_data.end(); ++ittop) {
        std::list<T> *grp = &(ittop->second);
        ret->push_back(grp);
    }

    return true;
}

#endif
