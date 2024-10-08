//https://www.acmicpc.net/problem/2577

#include<bits/stdc++.h>

using namespace std;

int A, B, C;
int res;
int chars[10];
int main(){

    cin >> A >> B >> C;

    res = A * B * C;

    //★★★★★
    string s = to_string(res);

    for (auto c : s) {
        chars[c - '0']++;
    }

    for (auto ele : chars){
        cout << ele << "\n";
    }


    return 0;
}