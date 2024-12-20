#include<iostream>
#include<tuple>

using namespace std;

int main() {

    tuple<int, int, int> t = make_tuple(1, 2, 3);
    int a, b, c;
    tie(a, b, c) = t;

    cout << a << b << c;

    return 0;
}