#include<bits/stdc++.h>

using namespace std;

const int MAX = 100;
vector<int> graph[MAX], cost[MAX];
int dist[MAX];
bool check[MAX]; // true : 이미 방문한 최단거리가 확정됨

int n, m;
int start, end2;

int main() {

    cin >> n >> m >> start >> end2;

    for (int i = 0; i < m; i++) {
        int a, b, c;
        cin >> a >> b >> c;

        graph[a].push_back(b);
        cost[a].push_back(c);
        
        graph[b].push_back(a);
        cost[b].push_back(c);
    }

    for (int i = 0; i < n; i++) dist[i] = 987654321;
    dist[start] = 0;

    for (int i = 0; i < n; i++) {
        //1. [출발, 노드]거리가 최소가 되는 노드를 구한다.(확정되지 않은, 방문한적 없었던)
        //2. 그 노드로 부터 주변으로 뻗어나간다.

        int minValue = 987654321, minIndex = -1;
        for (int j = 0; j < n; j++) {
            if (check[j] == false && minValue > dist[j]) {
                minValue = dist[j];
                minIndex = j;
            }
        }
        check[minIndex] = true;

        for (int j = 0; j < graph[minIndex].size(); j++) {
            int Node2 = graph[minIndex][j];
            int Cost2 =  cost[minIndex][j];

            if (dist[Node2] <= dist[minIndex] + Cost2) continue;

            dist[Node2] = dist[minIndex] + Cost2;
        }
    }

    for (int i = 0; i < n; i++)
        cout << dist[i] << " ";
    return 0;
}

/*
8 11 0 6
0 1 3
0 5 1
1 2 4
1 3 1
1 5 1
2 4 6
2 6 9
2 7 4
3 4 2
4 6 9
6 7 3
*/