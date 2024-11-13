//https://www.acmicpc.net/problem/3273

#include<bits/stdc++.h>

using namespace std;

int input;
int n, x;
vector<int> v;
int check[2000001];
int res;
// 128MB = 128_000_000 byte = 4byte * 32000000 개
int main(){

    ios::sync_with_stdio(0); cin.tie(0);

    cin >> n;

    // 사전에 check배열 미리 채워넣기
    for (int i = 0; i < n; i++){
        int temp;
        cin >> temp;
        v.push_back(temp);
        check[temp] = 1;
    }
    cin >> x;
//x: 8
//       1 2 3 4
//target 7 6 5 4


    for (int i = 0; i < n; i++) {
        int ele = v[i];
        int target = x - ele;
        if (target <= 0)continue;
        if (check[target]) res++;
    }

    cout << res/2;
    return 0;
}