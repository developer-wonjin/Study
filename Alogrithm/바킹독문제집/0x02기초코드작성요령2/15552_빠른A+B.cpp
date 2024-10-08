//https://www.acmicpc.net/problem/15552

#include<bits/stdc++.h>

using namespace std;

int main(){

    // 아래 코드가 없으면 시간초과가 나버림ㅎㅎ
    //ios::sync_with_stdio(0); cin.tie(0);

    int T;

    cin >> T;

    for (int i = 0; i < T; i++) {
        int a, b;
        cin >> a >> b;
        cout << a + b << "\n";
    }

    return 0;
}