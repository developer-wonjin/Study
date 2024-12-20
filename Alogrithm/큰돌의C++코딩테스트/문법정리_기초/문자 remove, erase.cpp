#include<bits/stdc++.h>

using namespace std;

int main(){
    ios::sync_with_stdio(0); cin.tie(0);

    string str = "ABC D E  F";
    cout << str << "\n";// ABC D E  F
    auto it = remove(str.begin(), str.end(), ' ');
    cout << str << "\n";// ABCDEFE  F

    // ABCDEF까지가 원하는 값이고, 뒤의 E  F는 쓸데없는 데이터가 남은 것.

    
    cout << it - str.begin();


    return 0;
}