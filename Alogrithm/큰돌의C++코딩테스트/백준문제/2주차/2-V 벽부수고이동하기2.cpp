// https://www.acmicpc.net/problem/14442

/*
벽 부수고 이동하기 2
시간 제한	메모리제한	제출	정답	맞힌 사람	정답 비율
2 초	    512 MB	    35285	    9943	6650	27.077%
문제
N×M의 행렬로 표현되는 맵이 있다. 
0은 이동할 수 있는 곳
1은 이동할 수 없는 벽

(1, 1)에서 (N, M)의 위치까지 이동
이때 최단 경로로 이동
시작하는 칸과 끝나는 칸도 포함해서 센다.

만약에 이동하는 도중에 벽을 부수고 이동하는 것이 좀 더 경로가 짧아진다면, 
벽을 K개 까지 부수고 이동하여도 된다.

맵이 주어졌을 때, 최단 경로를 구해 내는 프로그램을 작성하시오.

입력
첫째 줄에 N(1 ≤ N ≤ 1,000), M(1 ≤ M ≤ 1,000), K(1 ≤ K ≤ 10)이 주어진다. 
다음 N개의 줄에 M개의 숫자로 맵이 주어진다. 
(1, 1)과 (N, M)은 항상 0이라고 가정하자.

출력
첫째 줄에 최단 거리를 출력한다. 
불가능할 때는 -1을 출력한다.
*/

#include <bits/stdc++.h>

using namespace std;

int N, M, K;
char myMap[1000][1000];
int visited[11][1000][1000];

struct Node {
    int k, y, x;
};

int bfs() {
    int dy[4] = {-1, 1,  0, 0};
    int dx[4] = { 0, 0, -1, 1};
    queue<Node> q;

    visited[K][0][0] = 1;
    q.push({K, 0, 0});

    while(q.size()) {
        Node curr = q.front(); q.pop();

        if (curr.y == N - 1 && curr.x == M - 1) return visited[curr.k][N - 1][M - 1];

        for (int dir = 0; dir < 4; dir++) {
            int ny = curr.y + dy[dir];
            int nx = curr.x + dx[dir];

            // 영역검사
            if (ny < 0 || ny >= N || nx < 0 || nx >= M) continue;
            
            // 벽 검사
            if (myMap[ny][nx] == '1') {
                if (curr.k && visited[curr.k - 1][ny][nx] == 0) {
                    visited[curr.k - 1][ny][nx] = visited[curr.k][curr.y][curr.x] + 1;
                    q.push({curr.k - 1, ny, nx});
                }
                continue;
            }
            
            // 방문기록 검사
            if (visited[curr.k][ny][nx]) continue;
            visited[curr.k][ny][nx] = visited[curr.k][curr.y][curr.x] + 1;
            q.push({curr.k, ny, nx});
        }
        
    }
    return -1;
}

int main() {

    cin >> N >> M >> K;

    for (int y = 0; y < N; y++) {
        for (int x = 0; x < M; x++) {
            cin >> myMap[y][x];
        }
    }

    int ret = bfs();
    cout << ret << "\n";
    return 0;
}



/*
예제 입력 1 
6 4 1
0100
1110
1000
0000
0111
0000
예제 출력 1 
15
예제 입력 2 
6 4 2
0100
1110
1000
0000
0111
0000
예제 출력 2 
9
예제 입력 3 
4 4 3
0111
1111
1111
1110
예제 출력 3 
-1
*/