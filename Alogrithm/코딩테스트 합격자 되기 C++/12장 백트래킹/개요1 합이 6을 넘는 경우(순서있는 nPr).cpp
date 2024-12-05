#include<bits/stdc++.h>

using namespace std;

const int TOTAL = 6;
const int n = 4;
const int r = 2;
int arr[n] = {1, 2, 3, 4};
int check[n + 1];
vector<int> v;

// depth는 굳이 필요없지 싶다...
void dfs(int sum) {

    for (int i = 0; i < v.size(); i++) cout << v[i] << " ";
    cout << "\n";
    
    // r-1개를 뽑은 상황에서 0,1,2,,,r-2 의 마지막 요소에 대한 조건
    if (v.size() == r - 1 && v[r - 2] <= TOTAL - n)return;
    if (v.size() == r) {
        if (sum > TOTAL) cout << "---> 정답\n";
        return;        
    }

    for (int i = 0; i < n; i++) {
        int ele = i + 1;

        if (check[ele])continue;
        
        check[ele] = 1;
        v.push_back(i+1);
        dfs(sum + ele);
        check[i + 1] = 0;
        v.pop_back();
    }
}

int main() {

    dfs(0);

    return 0;
}