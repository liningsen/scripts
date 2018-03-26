#include <vector>
#include <iostream>
using namespace std;

class Point {
public:
    Point(int x, int y) : _x(x), _y(y) {
    }
    int _x;
    int _y;
private:
    Point();
};

class Seg {
public:
    Seg(const Point& s, const Point& e) : _st(s), _ed(e) {
    }
    Point _st;
    Point _ed;
};

class Solution {
public:
    bool build(const vector<int>& a) {
        if (a.empty()) 
            return false;

        int s = a.size();
        if (s % 4 == 0) {
            _H.reserve(s/4*2);
            _V.reserve(s/4*2);
        } else {
            _H.reserve((s/4+1)*2);
            _V.reserve((s/4+1)*2);
        }

        Point st(0, 0);
        Point ed(0, 0);
        for (int i = 0; i < s; ++i) {
            switch (i % 4) {
            case 0: 
                {
                ed._x = st._x;
                ed._y = st._y + a[i];
                Seg l1(st, ed);
                _V.push_back(l1);
                break;
                }
            case 1:
                {
                ed._x = st._x + a[i];
                ed._y = st._y;
                Seg l2(st, ed);
                _H.push_back(l2);
                break;
                }
            case 2:
                {
                ed._x = st._x;
                ed._y = st._y - a[i];
                Seg l3(st, ed);
                _V.push_back(l3);
                break;
                }
            case 3:
                {
                ed._x = st._x - a[i];
                ed._y = st._y;
                Seg l4(st, ed);
                _H.push_back(l4);
                break;
                }
            default:
                return false;
            }
            st = ed;
        }
        return true;
    }
    bool Check() {
        for (int i = 1; i < _H.size(); ++i) {
            for (int j = i-1; j >= 0; --j) {
                if (hasCrossed(_H[i], _V[j]))
                    return true;
            }
        }
        for (int i = 2; i < _V.size(); ++i) {
            for (int j = i-2; j >= 0; --j) {
                // if (hasCrossed(_V[i], _H[j]))
                // the same as
                if (hasCrossed(_H[j], _V[i]))
                    return true;
            }
        }
        return false;
    }
    bool hasCrossed(const Seg& lh, const Seg& lv) {
        Point left  = lh._st;
        Point right = lh._ed;
        Point up    = lv._st;
        Point down  = lv._ed;
        if (left._x > right._x) {
            swap(left, right);
        }
        if (up._y < down._y) {
            swap(up, down);
        }
        if (left._x <= up._x && right._x >= up._x) {
            if (left._y >= down._y && left._y <= up._y) {
                return true;
            }
        }
        return false;
    }
private:
    vector<Seg> _H; // Horizontal line
    vector<Seg> _V; // Vertical line
};

int main (int argc, char* argv[])
{
    vector<int> a{2,3,5,5,4,2};
    Solution s;
    if (s.build(a)) {
        cout << s.Check() << endl;
    }
    return 0;
}
