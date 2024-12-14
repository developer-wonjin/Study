// https://www.acmicpc.net/problem/1012

#include<bits/stdc++.h>

using namespace std;

/*
문제
배추를 해충으로부터 보호하는 것이 중요
이 지렁이는 '배추근처에 서식'하며 해충을 잡아 먹음으로써 배추를 보호한다. 
특히, 어떤 배추에 배추흰지렁이가 한 마리라도 살고 있으면 

이 지렁이는 인접한 다른 배추로 이동할 수 있어, 
그 배추들 역시 해충으로부터 보호받을 수 있다. 
한 배추의 상하좌우 네 방향에 다른 배추가 위치한 경우에 서로 인접해있는 것이다.

한나가 배추를 재배하는 땅은 고르지 못해서 배추를 군데군데 심어 놓았다. 
배추들이 모여있는 곳에는 배추흰지렁이가 한 마리만 있으면 되므로 
서로 인접해있는 배추들이 몇 군데에 퍼져있는지 조사하면 총 몇 마리의 지렁이가 필요한지 알 수 있다.
 예를 들어 배추밭이 아래와 같이 구성되어 있으면 최소 5마리의 배추흰지렁이가 필요하다. 
 0은 배추가 심어져 있지 않은 땅이고, 1은 배추가 심어져 있는 땅을 나타낸다.

1	1	0	0	0	0	0	0	0	0
0	1	0	0	0	0	0	0	0	0
0	0	0	0	1	0	0	0	0	0
0	0	0	0	1	0	0	0	0	0
0	0	1	1	0	0	0	1	1	1
0	0	0	0	1	0	0	1	1	1
입력
첫 줄 에는 테스트 케이스의 개수 T가 주어진다.

그 다음 줄부터 각각의 테스트 케이스에 대해 
첫째 줄에는 배추를 심은 배추밭의 가로길이 M(1 ≤ M ≤ 50)과 세로길이 N(1 ≤ N ≤ 50), 
그리고 배추가 심어져 있는 위치의 개수 K(1 ≤ K ≤ 2500)이 주어진다. 

그 다음 K줄에는 배추의 위치 X(0 ≤ X ≤ M-1), Y(0 ≤ Y ≤ N-1)가 주어진다. 
두 배추의 위치가 같은 경우는 없다.

출력
각 테스트 케이스에 대해 필요한 최소의 배추흰지렁이 마리 수를 출력한다.

2
10 8 17
0 0
1 0
1 1
4 2
4 3
4 5
2 4
3 4
7 4
8 4
9 4
7 5
8 5
9 5
7 6
8 6
9 6

10 10 1
5 5
*/
int T;
int N, M, K;

int myMap[51][51];
int visited[51][51];
int ans;

int dy[4] = {-1, 0, 1, 0};
int dx[4] = {0, 1, 0, -1};

void init() {
    for (int i = 0; i < 51; i++) {
        fill(myMap[i], myMap[i] + 51, 0);
        fill(visited[i], visited[i] + 51, 0);
    }
    ans = 0;

    cin >> N >> M >> K;

    int y, x;
    while(K--) {
        cin >> y >> x;
        myMap[y][x] = 1;
    }
}

void dfs(int y, int x) {
    visited[y][x] = 1;

    for (int dir = 0; dir < 4; dir++) {
        int ny = y + dy[dir];
        int nx = x + dx[dir];

        if (ny < 0 || ny >= N || nx < 0 || nx >= M) continue;
        if (myMap[ny][nx] == 0 || visited[ny][nx]) continue;

        dfs(ny, nx);
    }
}

void solve() {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < M; j++) {
            if (myMap[i][j] == 1 && visited[i][j] == 0) {
                ans++;
                dfs(i, j);
            }
        }
    }    
}

int main(){
    ios::sync_with_stdio(0); cin.tie(0);
    
    cin >> T;

    while(T--) {
        init();
        solve();
        cout << ans << "\n";
    }
    

    return 0;
}