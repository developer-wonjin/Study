#include<bits/stdc++.h>

using namespace std;

const int TOTAL = 5;
const int n = 4;

int arr[n] = {1, 2, 3, 4};
vector<int> v;

void dfs(int idx, int sum) {
    for (int i = 0; i < v.size(); i++) cout << v[i] << " ";
    cout << "\n";
    
    if (sum == TOTAL){
        cout << "-->정답후보\n";
        return;
    }
    if (sum > TOTAL) {
        cout << "-->백트레킹\n";
        return;
    }

    for (int i = idx + 1; i < n; i++) {
        int ele = arr[i];
        v.push_back(ele);
        dfs(i, sum + ele);
        v.pop_back();
    }
}

int main() {
    dfs(-1, 0);
    return 0;
}