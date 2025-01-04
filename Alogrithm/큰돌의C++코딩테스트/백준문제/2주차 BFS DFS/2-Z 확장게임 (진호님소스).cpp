#include<iostream>
#include<queue>
#include<utility>

using namespace std;

int N, M, P;

int S[10];
char myMap[1000][1000];
queue<pair<int, int>> q[10];
int result[10] = {0};

int dy[] = {-1, 1, 0, 0};
int dx[] = {0, 0, -1, 1};

 
int main() {
    cin >> N >> M >> P;
    for (int i = 1; i <= P; i++) cin >> S[i];

    // 게임판 초기화 및 플레이어의 성 위치 큐에 추가
    int emptySpace = 0;
    for (int y = 0; y < N; y++) {
        for (int x = 0; x < M; x++) {
            cin >> myMap[y][x];
            if (myMap[y][x] == '.')emptySpace++;
            if (myMap[y][x] >= '1' && myMap[y][x] <= '9') {
                int player = myMap[y][x] - '0';
                q[player].push({y, x});
                result[player]++;
            }
        }
    }
    
    bool flag = true;
    while (flag) {
        flag = false;
        for (int player = 1; player <= P; player++) {
            int maxSteps = S[player];
            while (maxSteps--) {
                int size = q[player].size();
                if(size == 0) break; 
                for (int i = 0; i < size; i++) {
                    auto [y, x] = q[player].front();
                    q[player].pop();

                    for (int dir = 0; dir < 4; dir++) {
                        int ny = y + dy[dir];
                        int nx = x + dx[dir];

                        if (ny < 0 || ny >= N || nx < 0 || nx >= M) continue;
                        if (myMap[ny][nx] != '.') continue;

                        myMap[ny][nx] = '0' + player;
                        result[player]++;
                        q[player].push({ny, nx});
                        flag = true;
                    }
                }
            }
        }
    }

    for (int i = 1; i <= P; i++) {
        cout << result[i] << " ";
    }
    return 0;
}

/*

5 5 2
2 1 
1 . . . . 
. # # # .
. # . # . 
. # # # .
. . . . 2


*/