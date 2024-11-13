// https://www.acmicpc.net/source/share/6b0acb8d4af043f88800c74b72d77610
#include<bits/stdc++.h>
using namespace std;

/*
문제

일곱 난쟁이의 키의 합 100

입력
아홉 개의 줄에 걸쳐 난쟁이들의 키가 주어진다. 
키는 100을 넘지 않는 자연수이며, 
키는 모두 다르며, 
가능한 정답이 여러 가지인 경우에는 아무거나 출력
20
7
23
19
10
15
25
8
13

출력
일곱 난쟁이의 키를 오름차순으로 출력한다. 일곱 난쟁이를 찾을 수 없는 경우는 없다.
7
8
10
13
19
20
23
*/

vector<int> heights(9);
pair<int, int> p;
int tot = 0;

unordered_map<int, int> umap; // {키 : 난쟁이순번}
void solve() {
    int twosum = tot - 100;

    for (int i = 0; i < 9; i ++) {
        int delta = twosum - heights[i];
        if (umap.find(delta) != umap.end()) {
            p = {i, umap[delta]};
            return;
        }
        umap[heights[i]] = i;
    }
    
}

int main(){
    ios::sync_with_stdio(0); cin.tie(0);

    for (int i = 0; i < 9; i++){
        cin >> heights[i];
        tot += heights[i];
    }

    sort(heights.begin(), heights.end());
    solve();
    for (int i = 0; i < 9; i++) {
        if (i == p.first || i == p.second)continue;
        cout << heights[i] << "\n";
    }


    return 0;
}