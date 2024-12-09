#include<iostream>
#include<vector>
#include<algorithm>

using namespace std;

int n = 4;
int r = 3;
vector<int> v = {1, 2, 3, 4};
vector<vector<int>> ans;

void printV(vector<int> &v) {
    for (int i = 0; i < r; i++) {
        cout << v[i] << " ";
    }
    cout << "\n";
}

void makePermutation(int depth){
    // cout << depth << "\n";
    
    if (r == depth) {
        ans.push_back(v);
        // for (int i = 0; i < v.size(); i++) cout << v[i] << " ";
        // cout << "\n";
        return;
    }

    for (int i = depth; i < n; i++) {
        swap(v[depth], v[i]);
        makePermutation(depth+1);
        swap(v[depth], v[i]);//제자리로 돌려놓기
    }
}

int main() {
    makePermutation(0);
    sort(ans.begin(), ans.end());

    for (int i = 0; i < ans.size(); i++) {
        for (int j = 0; j < r; j++) {
            cout << ans[i][j] << " ";
        }
        cout << "\n";
    }

    return 0;
}