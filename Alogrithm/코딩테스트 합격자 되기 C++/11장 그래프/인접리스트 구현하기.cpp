#include<bits/stdc++.h>

using namespace std;

vector<int> myGraph[10];
vector<int> weight[10];

int main() {

    int n, m;

    cin >> n >> m;
    for (int i = 0; i < m; i++) {
        int u, v, w;

        cin >> u >> v >> w;

        myGraph[u].push_back(v);
        myGraph[v].push_back(u);
        weight[u].push_back(w);
        weight[v].push_back(w);
    }


    return 0;
}

