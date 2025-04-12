#include<bits/stdc++.h>
typedef long long ll;
using namespace std;

ll arr[101];
ll cnt[101];
ll fibo (ll n) {
    cout << "fibo(" << n << ")" << "\n";
    cnt[n]++;

    if (n == 1) return 1;
    if (n == 2) return 1;

    return fibo(n-2) + fibo(n-1);
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