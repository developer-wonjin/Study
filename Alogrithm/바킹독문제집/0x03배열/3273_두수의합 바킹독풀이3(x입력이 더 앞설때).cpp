//https://www.acmicpc.net/problem/3273

#include<bits/stdc++.h>

using namespace std;

int input;
int n, x;
// int arr  [ 100001];
int check[2000001];
int res;
// 128MB = 128_000_000 byte = 4byte * 32000000 개
int main(){

    ios::sync_with_stdio(0); cin.tie(0);

    cin >> n;
    cin >> x; // x가 n개의 수보다 먼저 입력됐을 경우 arr을 사용하지 말고 풀 수 있다.
    
    for (int i = 0; i < n; i++){
        cin >> input;
        if (x - input >= 0 && check[x - input])res++;
        check[input] = 1;
    }

    cout << res;

    return 0;
}

/*
9
13
5 12 7 10 9 1 2 3 11
*/