#include<bits/stdc++.h>

using namespace std;

int n, tot;
vector<int> v;
vector<vector<int>> res;
void combi(int start, int sum) {

    for (const auto& ele : v) cout << ele << " ";
    cout << "\n";

    if (sum == tot) {
        res.push_back(v);
        return;
    }

    for (int i = start + 1; i <= n; i++) {
        v.push_back(i);
        combi(i, sum + i);
        v.pop_back();
    }
}

int main() {

    ios::sync_with_stdio(0); cin.tie(0);

    n = 7; tot = 10;
    combi(0, 0);
    
    cout << "======================\n";
    for (const auto& v : res) {
        for (const auto& ele : v) cout << ele << " ";
        cout << "\n";
    }

    return 0;
}