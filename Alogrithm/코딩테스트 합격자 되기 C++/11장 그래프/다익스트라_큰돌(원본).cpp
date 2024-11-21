#include <bits/stdc++.h>

using namespace std;

const int INF = 1e9; // 무한대 값 설정
vector<int>   graph[20004]; // 그래프의 인접 리스트 표현
vector<int> weights[20004];

int n, m, start;

vector<int> distance(20004, INF); // 최단 거리 배열

void dijkstra() {
    priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
    
    distance[start] = 0;
    pq.push({0, start});
    
    while (!pq.empty()) {
        int curr          = pq.top().second;
        int curr_distance = pq.top().first;
        pq.pop();
        
        // 느긋한 삭제
        if (curr_distance != distance[curr]) continue;
        
        for (int i = 0; i < graph[curr].size(); i++) {
            int next   =   graph[curr][i];
            int weight = weights[curr][i];
            int next_distance = curr_distance + weight;
            
            if (next_distance >= distance[next]) continue;

            distance[next] = next_distance;
            pq.push({next_distance, next});
        }
    }
}

int main() {
    
    cin >> n >> m >> start;
    for (int i = 0; i < m; i++) {
        int u, v, w;
        cin >> u >> v >> w;
        graph[u].push_back(v);
        weights[u].push_back(w);
    }
    dijkstra();
    for (int i = 1; i <= n; i++) {
        if (dist[i] == INF) cout << "INF\n";
        else cout << distance[i] << "\n";
    }
    return 0;
}
/*
5 7 1
1 2 1
1 3 4
2 3 2
2 3 1
2 4 5
3 4 1
4 5 2
*/

/*
0
1
2
3
5
*/