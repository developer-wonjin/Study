#include<bits/stdc++.h>
using namespace std;

int main() {
    string str1;
    string str2 = "hello";
    string str3(str2);
    string str4(str2, 2, 3); // (target, start, len)
    string str5(10, '*');

    cout << str1 << "\n";
    cout << str2 << "\n";
    cout << str3 << "\n";
    cout << str4 << "\n";
    cout << str5 << "\n";

}