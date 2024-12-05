#include <bits/stdc++.h>

using namespace std;

int arr[5];
int n = 5;
vector<int> v;
vector<vector<int>> ans;


void printV() {
    for (const auto& ele : v) {
        cout << ele << " ";
    }
    cout << "\n";
}
// int n = 5
//    0  1  2  3  4
        BS AS     
void combi(int start, int n) {

    printV();

    for (int i = start + 1; i < n; i++) {
        
        v.push_back(arr[i]); // 순번은 i 이지만 넣는건 배열값을 넣는다.
        combi(i, n);
        v.pop_back();
    }
}

vector<vector<int>> solution(int n) {
    for (int i = 0; i < n; i++) arr[i] = i + 1;
    combi(-1, n);
    return ans;
}

int main() {
    ios::sync_with_stdio(0); cin.tie(0);

    const vector<vector<int>>& res = solution(n);

    // 결과출력
    cout << "--------------------------------------------\n";
    for (const auto& v : res) {
        for (const auto& ele : v) cout << ele << " ";
        cout << "\n";
    }


    return 0;
}