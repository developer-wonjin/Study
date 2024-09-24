#include<bits/stdc++.h>
using namespace std;

int n, a[1004], cnt;
int go(int s, int e) {

    cout << "go(" << s << ", " << e << ")\n";

    if (s == e) return a[s];
    int mid = (s + e) / 2;
    return go(s, mid) + go(mid+1, e);
}
int main()
{
    cin >> n;

    for (int i=1; i<=n; i++){
        a[i-1] = i;
    }

    int sum = go(0, n-1);
    cout << sum << '\n';
    return 0;
}