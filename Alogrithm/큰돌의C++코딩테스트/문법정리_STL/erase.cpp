#include<bits/stdc++.h>

using namespace std;

int main(){
    ios::sync_with_stdio(0); cin.tie(0);
    vector<int> s {4, 3, 3, 5, 1, 2, 3};
    sort(s.begin(), s.end());
    s.erase(unique(s.begin(),s.end()),s.end());
    for(int i : s) cout << i << " ";
    return 0;
}