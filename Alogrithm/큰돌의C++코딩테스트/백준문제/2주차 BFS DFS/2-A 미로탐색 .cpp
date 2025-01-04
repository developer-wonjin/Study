// https://www.acmicpc.net/problem/2178

/*
문제
N×M크기의 배열로 표현되는 미로가 있다.
1	0	1	1	1	1
1	0	1	0	1	0
1	0	1	0	1	1
1	1	1	0	1	1
1: 이동할 수 있는 칸
0: 이동할 수 없는 칸

(1, 1)에서 출발하여 (N, M)의 위치로 이동할 때 
지나야 하는 '최소의 칸 수'를 구하는 프로그램을 작성하시오. 
한 칸에서 다른 칸으로 이동할 때, 서로 인접한 칸으로만 이동할 수 있다.

위의 예에서는 15칸을 지나야 (N, M)의 위치로 이동할 수 있다. 
(주의)칸을 셀 때에는 시작 위치와 도착 위치도 포함한다.

입력
첫째 줄에 두 정수 N, M(2 ≤ N, M ≤ 100)이 주어진다. 
다음 N개의 줄에는 M개의 정수로 미로가 주어진다. 
각각의 수들은 붙어서 입력으로 주어진다.

출력
첫째 줄에 지나야 하는 최소의 칸 수를 출력한다. 
항상 도착위치로 이동할 수 있는 경우만 입력으로 주어진다.
*/

#include<bits/stdc++.h>

using namespace std;

int N, M;
int myMap[101][101];
int visited[101][101];
char ch;

int dy[4] = {-1, 0, 1, 0};
int dx[4] = {0, 1, 0, -1};
int main() {

    cin >> N >> M;

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < M; j++) {
            cin >> ch;
            myMap[i][j] = ch;
        }
    }//myMap 입력완료

    queue<pair<int, int>> q;
    
    visited[0][0] = 1;
    q.push({0, 0});

    while(q.size()) {
        pair<int, int> curr = q.front(); q.pop();
        int cy = curr.first;
        int cx = curr.second;
        for (int dir = 0; dir < 4; dir++) {
            int ny = cy + dy[dir];
            int nx = cx + dx[dir];

            if (ny < 0 || ny >= N || nx < 0 || nx >= M) continue;
            if (myMap[ny][nx] == '0' || visited[ny][nx]) continue;

            visited[ny][nx] = visited[cy][cx] + 1;
            q.push({ny, nx});
        }
    }

    cout << visited[N-1][M-1] << "\n";

    return 0;
}
