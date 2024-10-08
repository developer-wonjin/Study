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

    // 입력을 받을 때 check배열을 채워놓는 방식
    for (int i = 0; i < n; i++){
        cin >> input;
        check[input] = 1;
    }
    cin >> x; // x가 n개의 수보다 먼저 입력됐을 경우 arr을 사용하지 말고 풀 수 있다.

    

    /*[정답패턴]
    for문의 범위는 x의 절반정도 
    따라서 x - val 의 음수 예외가 발생할 경우는 고려하지 X
    */
    for (int val = 1; val < (x+1)/2; val++) {
        if (check[val] && check[x - val]) {
            res++;
        }
    }

    cout << res;
    return 0;
}