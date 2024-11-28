#include<bits/stdc++.h>

using namespace std;

/*
0 0 0 0
0 0 0 0
0 1 E 0
S 1 0 0
*/
int dy[] = {-1, 0, 1, 0};
int dx[] = {0, 1, 0, -1};
char myMap[4][4] ={
    {'0', '0', '0', '0'},
    {'0', '0', '0', '0'},
    {'0', '1', 'E', '0'},
    {'S', '1', '0', '0'},
};
int visited[4][4];
int d;

void DFS (const pair<int, int>& curr) { // {y, x}
    if (myMap[curr.first][curr.second] == 'E') {
        d = min(d, visited[curr.first][curr.second]);
        return;        
    }

    for (int dir = 0; dir < 4; dir++) {
        int ny = curr.first  + dy[dir];
        int nx = curr.second + dx[dir];

        // 맵영역, 방문, 벽
        if (ny < 0 || ny >= 4 || nx < 0 || nx >= 4) continue;
        if (visited[ny][nx] > 0) continue;
        if (myMap[ny][nx] == '1') continue;

        visited[ny][nx] = visited[curr.first][curr.second] + 1;
        DFS({ny, nx});
        // visited[ny][nx] = 0;
    }
}

int main() {
    DFS({4, 0});

    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            cout << visited[i][j] << " ";
        }
        cout << "\n";
    }

    cout << d << "\n";
    return 0;
}

/*
12

4  5  6  7
3  0  9  8
2  0  0  0
1  0  0  0 
*/