// https://www.acmicpc.net/problem/2206

/*
벽 부수고 이동하기
시간 제한	메모리 제한	제출	정답	맞힌 사람	정답 비율
2 초	192 MB	159145	42326	26512	23.683%

문제
N×M의 행렬로 표현되는 맵이 있다. 

0은 이동할 수 있는 곳
1은 이동할 수 없는 벽

당신은 (1, 1)에서 (N, M)의 위치까지 이동하려 하는데, 이때 '최단 경로'로 이동하려 한다. 
시작하는 칸과 끝나는 칸도 포함해서 센다.

만약에 이동하는 도중에 한 개의 벽을 부수고 이동하는 것이 좀 더 경로가 짧아진다면, 
벽을 한 개 까지 부수고 이동하여도 된다.

한 칸에서 이동할 수 있는 칸은 상하좌우로 인접한 칸이다.

맵이 주어졌을 때, 최단 경로를 구해 내는 프로그램을 작성하시오.

입력
첫째 줄에 
N(1 ≤ N ≤ 1,000), 
M(1 ≤ M ≤ 1,000)이 주어진다. 

다음 N개의 줄에 M개의 숫자로 맵이 주어진다. (1, 1)과 (N, M)은 항상 0이라고 가정하자.

출력
첫째 줄에 최단 거리를 출력한다. 
'불가능'할 때는 -1을 출력한다.
*/

#include<bits/stdc++.h>

using namespace std;

int n, m;

char myMap[1000][1000];
int visited[2][1000][1000]; // 첫번째 차원 벽을 뿌시기 횟수

int ans = 987654321;

int dy[4] = {-1, 0, 1, 0};
int dx[4] = {0, 1, 0, -1};


void printV(int cnt) {
    cout << "기회 " << cnt << "회 남음\n";
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            cout << visited[cnt][i][j] << " ";
        }
        cout << "\n";
    }    
    cout << "\n";
}


int bfs() {
    
    queue<tuple<int, int, int>> q;
    visited[1][0][0] = 1;
    q.push(make_tuple(1, 0, 0));

    while(q.size()) {

        tuple<int ,int, int> curr = q.front(); q.pop();

        int cBreakCnt, cy, cx;
        tie(cBreakCnt, cy, cx) = curr;

        // cout << "(" << cy << ", " << cx << ")\n";
        // printV(cBreakCnt);

        if (cy == n-1 && cx == m-1) {
            return visited[cBreakCnt][cy][cx];
        }

        for (int dir = 0; dir < 4; dir++) {
            int ny = cy + dy[dir];
            int nx = cx + dx[dir];

            if (ny < 0 || ny >= n || nx < 0 || nx >= m) continue;
            
            // 벽일 때
            if (myMap[ny][nx] == '1') {
                if (cBreakCnt == 0 || visited[cBreakCnt - 1][ny][nx]) continue;
                visited[cBreakCnt - 1][ny][nx] = visited[cBreakCnt][cy][cx] + 1;
                q.push(make_tuple(cBreakCnt - 1, ny, nx));        
                continue;    
            } 

            if (visited[cBreakCnt][ny][nx]) continue;

            // 지나갈 수 있으면
            visited[cBreakCnt][ny][nx] = visited[cBreakCnt][cy][cx] + 1;
            q.push(make_tuple(cBreakCnt, ny, nx));
        }
    }
    return -1;
}

int main() {
    cin >> n >> m;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            cin >> myMap[i][j];
        }
    }

    cout << bfs() << "\n";




    return 0;
}

/*
예제 입력 1 
6 4
0100
1110
1000
0000
0111
0000
예제 출력 1 
15


예제 입력 2 
4 4
0111
1111
1111
1110
예제 출력 2 
-1
*/