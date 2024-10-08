//https://www.acmicpc.net/problem/3273

#include<bits/stdc++.h>

using namespace std;

int input;
int n, x;
int arr  [ 100001];
int check[2000001];
int res;
// 128MB = 128_000_000 byte = 4byte * 32000000 개
int main(){

    ios::sync_with_stdio(0); cin.tie(0);

    cin >> n;

    for (int i = 0; i < n; i++){
        cin >> arr[i];
    }
    cin >> x;


    /*[정답패턴]
    다음 두 줄은 반드시 선후관계를 뒤집으면 안된다.
    ex. 두 수의 합 x = 8 일 때 ele = 4 이면 res에 카운트가 되면 안된다.*/
    for (int arrIdx = 0; arrIdx < n; arrIdx++) {
        int ele = arr[arrIdx];
        if (x - ele > 0 && check[x - ele]) res++;
        check[ele] = 1;
    }

    cout << res;
    return 0;
}