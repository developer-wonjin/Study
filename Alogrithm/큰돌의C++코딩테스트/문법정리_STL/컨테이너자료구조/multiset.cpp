#include<bits/stdc++.h>

using namespace std;

int main(){
    ios::sync_with_stdio(0); cin.tie(0);

    multiset<int> m = {1, 1, 2, 2, 3, 3, 3};

    cout << m.count(3) << "\n";

    return 0;
}