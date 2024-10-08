#include<bits/stdc++.h>

using namespace std;

int main(){
    ios::sync_with_stdio(0); cin.tie(0);

    vector<int> a {1, 2, 3, 3, 3, 4};

    // 시간복잡도 logN (binary search)

    cout << lower_bound(a.begin(), a.end(), 3)- a.begin() << "\n"; // 2
    cout << upper_bound(a.begin(), a.end(), 3)- a.begin() << "\n"; // 5

    return 0;
}