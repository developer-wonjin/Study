// https://www.acmicpc.net/problem/4179
/*
불! 다국어
시간 제한	메모리 제한	제출	정답	맞힌 사람	정답 비율
1 초	256 MB	72323	16351	10734	20.764%
문제

지훈이의 위치와 
불이 붙은 위치를 감안해서 

지훈이가 불에 타기전에 탈출할 수 있는지의 여부, 
그리고 얼마나 빨리 탈출할 수 있는지를 결정해야한다.

지훈이와 불은 
매 분마다 한칸씩 수평또는 수직으로(비스듬하게 이동하지 않는다) 이동한다.

불은 각 지점에서 네 방향으로 확산된다.

지훈이는 미로의 가장자리에 접한 공간에서 탈출할 수 있다.

지훈이와 불은 벽이 있는 공간은 통과하지 못한다.

입력
입력의 첫째 줄에는 공백으로 구분된 
두 정수 R과 C가 주어진다. 
단, 1 ≤ R, C ≤ 1000 이다. 
R은 미로 행의 개수, 
C는 열의 개수이다.

다음 입력으로 R줄동안 각각의 미로 행이 주어진다.

각각의 문자들은 다음을 뜻한다.

#: 벽
.: 지나갈 수 있는 공간
J: 지훈이의 미로에서의 초기위치 (지나갈 수 있는 공간)
F: 불이 난 공간
J는 입력에서 하나만 주어진다.

출력
지훈이가 불이 도달하기 전에 미로를 탈출 할 수 없는 경우 IMPOSSIBLE 을 출력한다.

지훈이가 미로를 탈출할 수 있는 경우에는 가장 빠른 탈출시간을 출력한다.

*/

#include<bits/stdc++.h>

using namespace std;

int R, C;
char myMap[1000][1000];

struct Node {
    int y,x;
    char subj;
    int dis;
};

queue<Node> q;
int dy[] = {-1, 1, 0, 0};
int dx[] = {0, 0, -1, 1};

void printV() {
    for (int y = 0; y < R; y++) {
        for (int x = 0; x < C; x++){
            cout << myMap[y][x] << " ";
        }
        cout << "\n";
    }
    cout << "\n";
}

int bfs() {
    while(!q.empty()) {
        Node curr = q.front(); q.pop();
        int y = curr.y;
        int x = curr.x;
        char subj = curr.subj;
        int dis = curr.dis;

        // printV();

        if (subj == 'J' &&  (y == 0 || y == R - 1 || x == 0 || x == C - 1)) return dis;

        for (int dir = 0; dir < 4; dir++){
            int ny = y + dy[dir];
            int nx = x + dx[dir];

            if (ny < 0 || ny >= R || nx < 0 || nx >= C) continue;
            if (myMap[ny][nx] == 'F' || myMap[ny][nx] == '#')continue;
            
            if (subj == 'J' && myMap[ny][nx] == 'J') continue;

            // F --> . or J
            // J --> .
            myMap[ny][nx] = subj;
            q.push({ny, nx, subj, dis + 1});
        }
    }
    return -1;
}

int main () {
    ios::sync_with_stdio(0); cin.tie(0);

    cin >> R >> C;

    vector<Node> fires;
    Node human;

    for (int i = 0; i < R; i++) {
        for (int j = 0; j < C; j++) {
            cin >> myMap[i][j];
            if (myMap[i][j] == 'J'){
                human = {i, j, 'J', 1};
            }else if (myMap[i][j] == 'F'){
                fires.push_back({i, j, 'F', 1});
            }
        }
    }

    for (auto& fire : fires) q.push(fire);
    q.push(human);

    int res = bfs();
    if(res == -1) cout << "IMPOSSIBLE" << "\n";
    else cout << res << "\n";

    return 0;
}


/*
예제 입력 1 
4 4
####
#JF#
#..#
#..#
예제 출력 1 
3

4 4
####
#J.#
#.F#
#..#
*/