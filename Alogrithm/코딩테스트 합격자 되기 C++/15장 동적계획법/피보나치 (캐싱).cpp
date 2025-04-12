#include<bits/stdc++.h>
typedef long long ll;
using namespace std;

ll arr[101];
ll cnt[101];

// 1. 부분문제를 정의한다.
// ll fibo(ll n) : n번째 피보나치수를 리턴 즉, F(i)
ll fibo (ll n) {
    cout << "fibo(" << n << ")" << "\n";

    if (n == 1) return 1;
    if (n == 2) return 1;

    // 캐싱에서 찾기
    if (arr[n] > 0) return arr[n];
    // 캐싱에서 없으면 캐싱하기
    cnt[n]++;

    //2. 점화식을 구한다
    ll res = fibo(n-2) + fibo(n-1);
    arr[n] = res;

    return res;
}

int main() {

    ios::sync_with_stdio(0); cin.tie(0);

    ll n;
    cin >> n;

    cout << fibo(n) << "\n";

    for (int i = 1; i <= n; i++) {
        cout << cnt[i] << " ";
    }

    return 0;
}