#include <iostream>

using namespace std;

// class A
// {
// public:
//     A() {}
//     ~A(){}
// };

struct A1 {
    int i;
    char c;
};
struct A2 {
    int i;
    char carr[6];
};
struct A3 {
    int i;
    char c;
    struct A2 sa2;
};
union A4 {
    int i;
    char c;
};
union A5 {
    int i;
    char carr[6];
};
struct A6 {
    int i;
    char c;
    struct A2 sa2;
    union A4 ua4;
};
struct A7 {
    int i;
    char c;
    struct A2 sa2;
    union A4 ua4;
    union A5 ua5;
};
int main(int argc, char* argv[])
{
    // A a;
    // cout << sizeof(a) << endl;
    cout << "A1 " << sizeof(A1) << endl; // 8
    cout << "A2 " << sizeof(A2) << endl; // 12
    cout << "A3 " << sizeof(A3) << endl; // 4+(1->4)+12(max=4) = 4+4+12 = 20
    cout << "A4 " << sizeof(A4) << endl; // 4
    cout << "A5 " << sizeof(A5) << endl; // 8
    cout << "A6 " << sizeof(A6) << endl; // 4+4+12+4=24
    cout << "A7 " << sizeof(A7) << endl; // 4+4+12+4+8=32
    return 0;
}
