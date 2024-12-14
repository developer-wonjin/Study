#include<bits/stdc++.h>

using namespace std;

const int TOTAL = 5;
const int n = 4;

int arr[n] = {1, 2, 3, 4};
vector<int> v;

void dfs(int idx, int sum) {
    cout << "idx: " << idx << ", sum: " << sum << " | ";
    for (const auto& ele : v) cout<< ele << " ";
    cout << "\n";
    
    // if (sum == TOTAL) {
    //     cout << "-->정답후보\n";
    //     return;
    // }
    // if (sum > TOTAL){
    //     cout << "-->백트레킹\n";
    //     return;
    // }

    // 순서 중요하다....가장 맨 아래 있어야해... 안 그러면 {1,4}후보를 누락시킴
    if (idx == n - 1)return;

    // 0 1 2 3
    // 1 2 3 4

    // O
    v.push_back(arr[idx + 1]); // v.push_back(arr[3])
    dfs(idx + 1, sum + arr[idx + 1]); // dfs(3, sum + arr[3]);
    // X
    v.pop_back();
    dfs(idx + 1, sum);
}

int main() {
    dfs(-1, 0);
    //dfs(0, 0);
    return 0;
}