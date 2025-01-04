// https://www.acmicpc.net/problem/16933

/*
벽 부수고 이동하기 3
시간 제한	메모리 제한	제출	정답	맞힌 사람	정답 비율
2 초	512 MB	20125	4928	3243	23.065%
문제
N×M의 행렬로 표현되는 맵이 있다. 

0은 이동할 수 있는 곳
1은 이동할 수 없는 벽
당신은 (1, 1)에서 (N, M)의 위치까지 이동하려 하는데, 
이때 최단 경로로 이동하려 한다. 
이때 시작하는 칸과 끝나는 칸도 포함해서 센다. 

입력
첫째 줄에 N(1 ≤ N ≤ 1,000), M(1 ≤ M ≤ 1,000), K(1 ≤ K ≤ 10)이 주어진다. 다음 N개의 줄에 M개의 숫자로 맵이 주어진다. (1, 1)과 (N, M)은 항상 0이라고 가정하자.

출력
첫째 줄에 최단 거리를 출력한다. 불가능할 때는 -1을 출력한다.
*/

#include <bits/stdc++.h>
using namespace std;

bool myMap[1000][1000];
int visited[11][1000][1000][2]; // [k][y][x][day] (횟수, y, x, 낮밤)
int N, M, K;

struct Node {
    int k, day, y, x;
};

int dy[] = {-1, 1, 0, 0, 0};
int dx[] = {0, 0, -1, 1, 0};

int bfs() {
    queue<Node> q;
    q.push({K, 1, 0, 0});
    visited[K][0][0][1] = 1; // 시작 위치 방문 (낮)

    while (!q.empty()) {
        Node curr = q.front();
        q.pop();

        int k = curr.k, day = curr.day, y = curr.y, x = curr.x;
        int dist = visited[k][y][x][day];

        // 도착 지점에 도달
        if (y == N - 1 && x == M - 1) return dist;
    

        // 4방향 이동
        for (int dir = 0; dir < 5; dir++) {
            int ny = y + dy[dir];
            int nx = x + dx[dir];

            // dir = 4 일 때만 유효한 코드 즉, 제자리일 때 처리
            if (ny == y && nx == x) {
                if (visited[k][y][x][1 - day] < dist + 1) continue;
                
                visited[k][y][x][1 - day] = dist + 1;
                q.push({k, 1 - day, y, x});
                continue;
            }

            if (ny < 0 || ny >= N || nx < 0 || nx >= M) continue; // 맵 경계 체크

            // 벽을 만난 경우
            if (myMap[ny][nx] == 1) {
                if (day == 1 && k > 0 && visited[k - 1][ny][nx][0] == 0) { // 낮이고, 벽을 부술 수 있다면
                    visited[k - 1][ny][nx][0] = dist + 1;
                    q.push({k - 1, 0, ny, nx}); // 밤으로 전환
                }
                continue;
            }

            // 빈 칸인 경우
            if (visited[k][ny][nx][1 - day] == 0) {
                visited[k][ny][nx][1 - day] = dist + 1;
                q.push({k, 1 - day, ny, nx});
            }
        }
    }

    return -1; // 도달 불가능
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(0);

    cin >> N >> M >> K;

    for (int y = 0; y < N; y++) {
        for (int x = 0; x < M; x++) {
            char ch;
            cin >> ch;
            myMap[y][x] = ch - '0';
        }
    }

    cout << bfs() << "\n";

    return 0;
}


/*
예제 입력 1 
1 4 1
0010
예제 출력 1 
5


예제 입력 2 
1 4 1
0100
예제 출력 2 
4


예제 입력 3 
6 4 1
0100
1110
1000
0000
0111
0000
예제 출력 3 
15


예제 입력 4 
6 4 2
0100
1110
1000
0000
0111
0000
예제 출력 4 
9
*/