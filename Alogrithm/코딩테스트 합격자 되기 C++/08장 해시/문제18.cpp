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

    for (int i = 0; i < n; i++){
        int temp;
        cin >> temp;
        v.push_back(temp);
        check[temp] = 1;
    }
    cin >> x;

    /*[정답패턴]
    다음 두 줄은 반드시 선후관계를 뒤집으면 안된다.
    ex. 두 수의 합 x = 8 일 때 ele = 4 이면 res에 카운트가 되면 안된다.*/
    for (int i = 0; i <n ; i++) {
        int ele = v[i];
        int target = x - ele;
        if (target <= 0)continue;
        if (target == ele)continue;        
        if (check[target]) res++;
    }

    cout << res/2;
    return 0;
}