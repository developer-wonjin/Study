#include<bits/stdc++.h>

using namespace std;

bool comp(int a, int b){
    if (a == b) return 0;
    return a < b;
}

int main() {
    ios::sync_with_stdio(0); cin.tie(0);
    int a;
    vector<int> v;
    for (int i = 0; i < 3; i++) {
        cin >> a;
        v.push_back(a);
    }

    sort(v.begin(), v.end(), comp);
    
    for (auto ele : v) cout << ele << " ";
    return 0;
}