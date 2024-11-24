#include<vector>
#include<queue>
#include<iostream>

using namespace std;

int n, m;
int visited[101][101];
int dy[] = {-1, 0, 1, 0};
int dx[] = {0, 1, 0, -1};

int bfs(vector<vector<int> >& maps) {
    queue<pair<int, int>> q;
    
    visited[0][0] = 1;
    q.push({0, 0});
    
    while(q.size()) {
        pair<int, int> curr = q.front(); q.pop();
        
        if (curr.first == n-1 && curr.second == m-1)
            return visited[curr.first][curr.second];
        
        for (int dir = 0; dir < 4; dir++) {
            int ny = curr.first + dy[dir];
            int nx = curr.second + dx[dir];
            
            if (ny < 0 || ny >= n || nx < 0 || nx >= m) continue;
            if (maps[ny][nx] == 0) continue;
            if (visited[ny][nx] > 0) continue;
            
            visited[ny][nx] = visited[curr.first][curr.second] + 1;
            q.push({ny, nx});
        }
    }
    
    return -1;
}
int solution(vector<vector<int> > maps)
{
    n = maps.size();
    m = maps[0].size();
    
    return bfs(maps);
}