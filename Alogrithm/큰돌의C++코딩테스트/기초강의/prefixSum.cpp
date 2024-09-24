#include<bits/stdc++.h>

using namespace std;

int a[100004], myStart, myEnd, prefixSum[100004], n, m;

int main(){
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    cout.tie(NULL);

    cin >> n >> m;

    for (int i = 1; i <= n; i++){
        cin >> a[i];
        prefixSum[i] = prefixSum[i-1] + a[i];
    }

    for (int i = 0; i < m; i++){
        cin >> myStart >> myEnd;
        cout << prefixSum[myEnd] - prefixSum[myStart - 1] << "\n";
    }


}