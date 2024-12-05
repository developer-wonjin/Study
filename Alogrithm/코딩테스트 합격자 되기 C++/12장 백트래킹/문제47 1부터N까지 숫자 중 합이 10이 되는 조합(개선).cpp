#include <bits/stdc++.h>

using namespace std;

int arr[10];
int n = 5, m = 4;
vector<int> v;
vector<vector<int>> ans;


void printV() {
    for (const auto& ele : v) {
        cout << ele << " ";
    }
    cout << "\n";
}

void combi(int start, int n, int sum) {

    // printV();

    if (sum == m){
        ans.push_back(v);
        return;
    } else if (sum > m) {
        return;
    }


    for (int i = start + 1; i < n; i++) {
        
        v.push_back(arr[i]); // 순번은 i 이지만 넣는건 배열값을 넣는다.
        combi(i, n, sum + arr[i]);
        v.pop_back();
    }

}

vector<vector<int>> solution(int n) {
    for (int i = 0; i < n; i++) arr[i] = i + 1;
    combi(-1, n, 0);
    return ans;
}

int main() {
    ios::sync_with_stdio(0); cin.tie(0);

    const vector<vector<int>>& res = solution(n);

    //결과출력
    for (const auto& v : res) {
        for (const auto& ele : v) cout << ele << " ";
        cout << "\n";
    }


    return 0;
}