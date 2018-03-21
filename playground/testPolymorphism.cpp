#include <iostream>
using namespace std;

class Base
{
public:
    virtual void f() {
        cout << "Base::f" << endl;
    }
    virtual void g() {
        cout << "Base::g" << endl;
    }
};

typedef void (*FuncType) ();
void (*myFunc) ();

void g_f() {
    cout << "global::f" << endl;
}

int main (int argc, char * argv[])
{
    Base b;
    myFunc = g_f;
    // FuncType = g_f; // expected unqualified-id
    FuncType pfunc = NULL;
    pfunc = g_f;
    // test on Mac 64bit
    // int *vptr = (int*) (&b);
    long *vptr = (long*) (&b);
    cout << "vptr " << vptr << endl;
    cout << "vptr addr " << (int*) vptr << endl;
    cout << "vptr addr " << (long*) vptr << endl;
    cout << "vptr content " << (int*) *vptr << endl;
    cout << "vptr content " << (long*) *vptr << endl;
    // int *vtbl = (int*) *vptr;
    long *vtbl = (long*) *vptr;
    cout << "vptr content is the address of vtbl. vtbl addr " << (int*) vtbl << endl;
    cout << "vptr content is the address of vtbl. vtbl addr " << (long*) vtbl << endl;
    cout << "the 0th element of vtbl, the vtbl[0] content is " << (int*) vtbl[0] << (int*)  *(vtbl+0) << " it's the address of firest virtual function addr"<< endl;
    cout << "the 0th element of vtbl, the vtbl[0] content is " << (long*) vtbl[0] << (long*)  *(vtbl+0) << " it's the address of firest virtual function addr"<< endl;
    cout << "the 1th element of vtbl, the vtbl[1] content is " << (int*) vtbl[1] << (int*)  *(vtbl+1) << " it's the address of second virtual function addr"<< endl;
    cout << "the 1th element of vtbl, the vtbl[1] content is " << (long*) vtbl[1] << (long*)  *(vtbl+1) << " it's the address of second virtual function addr"<< endl;
    pfunc = (FuncType) vtbl[0];
    pfunc();
    pfunc = (FuncType) *(vtbl+0);
    pfunc();
    pfunc = (FuncType) *( ((long*)  *vptr) + 0 );
    pfunc();
    pfunc = (FuncType) *(    ( (long*)  *((long*)(&b)) ) + 0    );
    pfunc();
    pfunc = (FuncType) vtbl[1];
    pfunc();
    pfunc = (FuncType) *(    ( (long*) (*(long*)(&b)) )+1  );
    pfunc();
    return 0;
}
