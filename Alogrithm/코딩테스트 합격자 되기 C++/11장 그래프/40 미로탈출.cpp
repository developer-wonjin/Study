#include <string>
#include <vector>
#include <queue>
#include <iostream>
/*
프로그래머스 미로 탈출

1 x 1 크기의 칸
각 칸은 {통로,벽}
벽으로 된 칸은 지나갈 수 없고
통로로 된 칸으로만 이동할 수 있습니다. 

통로들 중 한 칸에는 미로를 빠져나가는 문이 있는데, 
이 문은 레버를 당겨서만 열 수 있습니다. 

레버 또한 통로들 중 한 칸에 있습니다. 
따라서, 출발 지점에서 먼저 레버가 있는 칸으로 이동하여 레버를 당긴 후 미로를 빠져나가는 문이 있는 칸으로 이동하면 됩니다. 

이때 아직 레버를 당기지 않았더라도 출구가 있는 칸을 지나갈 수 있습니다. 
미로에서 한 칸을 이동하는데 1초가 걸린다고 할 때, 
최대한 빠르게 미로를 빠져나가는데 걸리는 시간을 구하려 합니다.

출구는 레버가 당겨지지 않아도 지나갈 수 있으며, 모든 통로, 출구, 레버, 시작점은 '여러 번' 지나갈 수 있습니다.
*/
using namespace std;

int n, m;
pair<int, int> S, E, L;

int dy[] = {-1, 0, 1, 0};
int dx[] = {0, 1, 0, -1};

int bfs (pair<int, int>& start, pair<int, int>& target, vector<string>& maps) {
    queue<pair<int, int>> q;
    int visited[101][101] = {0, };// 이렇게 초기화해도 되나?    
    
    visited[start.first][start.second] = 1;
    q.push(start);
    
    
    while(q.size()) {
        pair<int, int>& curr = q.front(); q.pop();
        if (curr == target) return visited[curr.first][curr.second] - 1;
        
        for(int dir = 0; dir < 4; dir++) {
            int ny = curr.first + dy[dir];
            int nx = curr.second + dx[dir];
            if (ny < 0 || ny >= n || nx < 0 || nx >= m) continue;
            if (maps[ny][nx] == 'X') continue;
            if (visited[ny][nx] > 0) continue;
            
            visited[ny][nx] = visited[curr.first][curr.second] + 1;
            q.push({ny, nx});
        }
    }
    return -1;
}

int solution(vector<string> maps) {
    int answer = 0;
    n = maps.size();
    m = maps[0].size();
    
    for (int i = 0; i < n; i ++) {
        for (int j = 0; j < m; j++){
            if (maps[i][j] == 'S') S = {i, j};
            else if (maps[i][j] == 'E') E = {i, j};
            else if (maps[i][j] == 'L') L = {i, j};
        }
    }
    
    int ret1 = bfs(S, L, maps); // 레버를 찾는 여정
    if (ret1 == -1) return -1;
    int ret2 = bfs(L, E, maps); // 도착지를 찾는 여정
    if (ret2 == -1) return -1;
    
    return ret1 + ret2;
}