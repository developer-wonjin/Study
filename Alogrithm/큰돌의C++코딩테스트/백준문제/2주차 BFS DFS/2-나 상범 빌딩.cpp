// https://www.acmicpc.net/problem/6593

/*
상범 빌딩 실패다국어
시간 제한	메모리 제한	제출	정답	맞힌 사람	정답 비율
1 초	128 MB	24522	9744	7696	39.104%

문제
당신은 상범 빌딩에 갇히고 말았다. 
여기서 탈출하는 가장 빠른 길은 무엇일까? 
상범 빌딩은 각 변의 길이가 1인 정육면체(단위 정육면체)로 이루어져있다.
각 정육면체는 금으로 이루어져 있어 지나갈 수 없거나, 비어있어서 지나갈 수 있게 되어있다.
당신은 각 칸에서 인접한 6개의 칸(동,서,남,북,상,하)으로 1분의 시간을 들여 이동할 수 있다.
즉, 대각선으로 이동하는 것은 불가능하다. 그리고 상범 빌딩의 바깥면도 모두 금으로 막혀있어 출구를 통해서만 탈출할 수 있다.

당신은 상범 빌딩을 탈출할 수 있을까? 만약 그렇다면 얼마나 걸릴까?

입력
입력은 여러 개의 테스트 케이스로 이루어지며, 각 테스트 케이스는 세 개의 정수 L, R, C로 시작한다. L(1 ≤ L ≤ 30)은 상범 빌딩의 층 수이다. R(1 ≤ R ≤ 30)과 C(1 ≤ C ≤ 30)는 상범 빌딩의 한 층의 행과 열의 개수를 나타낸다.

그 다음 각 줄이 C개의 문자로 이루어진 R개의 행이 L번 주어진다. 각 문자는 상범 빌딩의 한 칸을 나타낸다. 금으로 막혀있어 지나갈 수 없는 칸은 '#'으로 표현되고, 비어있는 칸은 '.'으로 표현된다. 당신의 시작 지점은 'S'로 표현되고, 탈출할 수 있는 출구는 'E'로 표현된다. 각 층 사이에는 빈 줄이 있으며, 입력의 끝은 L, R, C가 모두 0으로 표현된다. 시작 지점과 출구는 항상 하나만 있다.

출력
각 빌딩에 대해 한 줄씩 답을 출력한다. 만약 당신이 탈출할 수 있다면 다음과 같이 출력한다.

Escaped in x minute(s).
여기서 x는 상범 빌딩을 탈출하는 데에 필요한 최단 시간이다.

만일 탈출이 불가능하다면, 다음과 같이 출력한다.

Trapped!
예제 입력 1 
3 4 5
S....
.###.
.##..
###.#

#####
#####
##.##
##...

#####
#####
#.###
####E

1 3 3
S##
#E#
###

0 0 0
예제 출력 1 
Escaped in 11 minute(s).
Trapped!
*/

#include<bits/stdc++.h>

using namespace std;

int L, R, C;
char myMap[31][31][31];
bool visited[31][31][31];

struct Node {
    int z, y, x;
    int dis;
};
queue<Node> q;
int dz[] = {-1, 1, 0, 0, 0, 0};
int dy[] = {0, 0, -1, 1, 0, 0};
int dx[] = {0, 0, 0, 0, 1, -1};

int bfs() {
    
    while(!q.empty()) {
        Node curr = q.front(); q.pop();
        int z = curr.z;
        int y = curr.y;
        int x = curr.x;
        int dis = curr.dis;

        if (myMap[z][y][x] == 'E') return dis;

        for (int dir = 0; dir < 6; dir++) {
            int nz = z + dz[dir];
            int ny = y + dy[dir];
            int nx = x + dx[dir];

            if (nz < 0 || nz >= L || ny < 0 || ny >= R || nx < 0 || nx >= C) continue;
            if (visited[nz][ny][nx] || myMap[nz][ny][nx] == '#') continue;
            visited[nz][ny][nx] = 1;
            q.push({nz, ny, nx, dis + 1});
        }
    }
    return -1;
}

int main () {

    ios::sync_with_stdio(0);cin.tie(0);

    while(1) {
        cin >> L >> R >> C;

        if (L == 0 && R == 0 && C == 0)break;

        for (int z = 0; z < L; z++) {

            for (int y = 0; y < R; y++) {
                for (int x = 0; x < C; x++) {
                    cin >> myMap[z][y][x];
                    if (myMap[z][y][x] == 'S')q.push({z, y, x});
                }
            }
        }

        int res = bfs();
        if (res == -1) {
            cout << "Trapped!" << "\n";
        } else {
            cout << "Escaped in " << res << " minute(s)." << "\n";
        }

        while(!q.empty()) q.pop();        
        for (int z = 0; z < L; z++) {
            for (int y = 0; y < R; y++) {
                for (int x = 0; x < C; x++) {
                    visited[z][y][x] = 0;
                }
            }
        }
    }

    return 0;
}