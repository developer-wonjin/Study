#include<bits/stdc++.h>

using namespace std;

const int NMAX = 4;
// char myMap[NMAX][NMAX] = {
//     {'0', '0', '0', 'E'},
//     {'0', '0', '0',  '0'},
//     {'0', '0', '0', '0'},
//     {'0', '0', '0', '0'},
// };

char myMap[NMAX][NMAX] = {
    {'0', '0', '0', '0'},
    {'0', '0', '0', '0'},
    {'0', 'X', 'E', '0'},
    {'0', 'X', '0', '0'},
};

vector <vector<int>> visited(NMAX, vector<int>(NMAX, 0));

vector<vector <vector<int>>> ans;

//           U   R D  L
int dy[4] = {-1, 0, 1, 0};
int dx[4] = {0, 1, 0, -1};

// up R L down
// int dy[4] = {-1, 0, 0, 1};
// int dx[4] = {0, 1, -1, 0};

//           R  D   L  U
// int dy[4] = {0, 1, 0, -1};
// int dx[4] = {1, 0, -1, 0};

//           R   U  L  D 
// int dy[4] = {0, -1, 0, 1};
// int dx[4] = {1, 0, -1, 0};

void printMap() {
    for (int i = 0; i < NMAX; i++) {
        for (int j = 0; j < NMAX; j++) {
            if (myMap[i][j] == 'X') cout << " X ";
            else if (visited[i][j] == 0) cout << " - ";
            else if (visited[i][j] < 10) cout << "0" + to_string(visited[i][j]) << " ";
            else cout << visited[i][j] << " ";
        }
        cout << "\n";
    }
    cout << "\n";    
}

// Start => End 갈 수 있는 모든 경우의 수 구해라! (단, 이동거리의 비효율은 허용한다)
void dfs (int y, int x) {
    printMap();

    if (myMap[y][x] == 'E') {
        cout << "도달함\n";
        return;
    }

    for (int dir = 0; dir < 4; dir++) {
        int ny = y + dy[dir];
        int nx = x + dx[dir];

        if (ny < 0 || ny >= NMAX || nx < 0 || nx >= NMAX) continue;
        if (visited[ny][nx]) continue;
        if (myMap[ny][nx] == 'X') continue;

        visited[ny][nx] = visited[y][x] + 1;
        dfs (ny, nx);
        visited[ny][nx] = 0;
    }

    cout << "도달 못함\n";
}

int main() {
    ios::sync_with_stdio(0); cin.tie(0);

    visited[3][0] = 1;
    dfs(3, 0);

    return 0;
}