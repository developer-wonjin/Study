#include<cstdio>
#include<vector>

using namespace std;

const int MAX = 10000;
int n, m;
vector <int> myGraph[MAX];

bool visited[MAX];

int countNum = 0;
void DFS(int node) {
    //printf("방문노드: %d\n", node);
    //printf("judge: %d\n", judge);
    visited[node] = true;
    countNum++;
    
    for (int i = 0; i < myGraph[node].size(); i++) {
        int next = myGraph[node][i];
        if (visited[next] == false)
            DFS(next);
    }
}

int main() {
    scanf("%d\n%d", &n, &m);
    for (int i = 0; i < m; i++)
    {
        int a, b;
        scanf("%d %d", &a, &b);
        myGraph[a].push_back(b);
        myGraph[b].push_back(a);
    }
    DFS(1);
    printf("%d", countNum - 1);

    return 0;
}