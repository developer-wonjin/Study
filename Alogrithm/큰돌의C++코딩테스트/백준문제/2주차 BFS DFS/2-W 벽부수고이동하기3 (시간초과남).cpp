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

#include<bits/stdc++.h>

using namespace std;

bool myMap[1000][1000];
int visited[11][1000][1000];

int N, M, K;

struct Node {
    int k, day, y, x;
};
int dy[] = {-1, 1, 0, 0, 0};
int dx[] = {0, 0, -1, 1, 0};
queue<Node> q;

void printV(int k) {
    for (int y = 0; y < N; y++) {
        for (int x = 0; x < M; x++) {
            cout << visited[k][y][x] << " ";
        }
        cout << "\n";
    }
    cout << "\n";
}

int bfs() {
    visited[K][0][0] = 1;
    q.push({K, 1, 0, 0}); //k, day, y, x;
    // printV(K); cout << "\n";

    while(q.size()) {

        Node curr = q.front(); q.pop();

        int k = curr.k;
        int day = curr.day;
        int y = curr.y;
        int x = curr.x;
        
        if (y == N - 1 && x == M - 1) return visited[k][y][x];

        for (int dir = 0; dir < 5; dir++) {
            int ny = y + dy[dir];
            int nx = x + dx[dir];

            //이동하지 않고 같은 칸에 머물러있는 경우
            if (ny == y && nx == x) {
                visited[k][y][x]++;//이 경우도 방문한 칸의 개수가 하나 늘어나는 것으로 생각해야 한다.
                q.push({k, !day, y, x}); //이동하지 않고 같은 칸에 머무르는 경우에도 낮과 밤이 바뀌게 된다.
                continue;
            }

            // 영역 검사
            if (ny < 0 || ny >= N || nx < 0 || nx >= M) continue;
            
            
            /*
            만약에 이동하는 도중에 벽을 부수고 이동하는 것이 좀 더 경로가 짧아진다면, 
            벽을 K개 까지 부수고 이동하여도 된다. 
            단, 벽은 낮에만 부술 수 있다.
            */
            
            // 벽 검사
            if (myMap[ny][nx] == 1) {
                // 현재 기회가 있고
                // 현재 낮이고
                // 다음 장소를 방문한적 없으면
                if (k && visited[k - 1][ny][nx] == 0 && day == 1) {
                    visited[k - 1][ny][nx] = visited[k][y][x] + 1;
                    q.push({k-1, !day, ny, nx});
                }
                continue;
            }

            // 방문 검사
            if (visited[k][ny][nx]) continue;
            visited[k][ny][nx] = visited[k][y][x] + 1;
            q.push({k, !day, ny, nx});
        }
    }
}

int main() {

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