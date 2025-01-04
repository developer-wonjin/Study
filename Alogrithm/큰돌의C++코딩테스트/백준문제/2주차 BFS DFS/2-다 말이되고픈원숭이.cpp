// https://www.acmicpc.net/problem/1600

/*
문제

말은 격자판에서 체스의 나이트와 같은 이동방식을 가진다. 다음 그림에 말의 이동방법이 나타나있다. 
x표시한 곳으로 말이 갈 수 있다는 뜻이다. 참고로 말은 장애물을 뛰어넘을 수 있다.
 	x	 	x	 
x	 	 	 	x
 	 	말	 	 
x	 	 	 	x
 	x	 	x	 

말은 저렇게 움직일 수 있지만 원숭이는 능력이 부족해서 총 K번만 위와 같이 움직일 수 있고, 
그 외에는 그냥 인접한 칸으로만 움직일 수 있다. 
대각선 방향은 인접한 칸에 포함되지 않는다.


인접한 네 방향으로 한 번 움직이는 것, 말의 움직임으로 한 번 움직이는 것, 모두 한 번의 동작으로 친다.

격자판이 주어졌을 때, 
원숭이가 최소한의 동작으로 시작지점에서 도착지점까지 갈 수 있는 방법을 알아내는 프로그램을 작성하시오.


출력
첫째 줄에 원숭이의 동작수의 최솟값을 출력한다. 시작점에서 도착점까지 갈 수 없는 경우엔 -1을 출력한다.


*/

#include<bits/stdc++.h>

using namespace std;

int K, W, H;
// W와 H는 1이상 200이하의 자연수이고, K는 0이상 30이하의 정수이다.
int myMap[201][201];
bool visited[201][201][31];
struct Node {
    int y, x;
    int k;
    int dis;
};
int dy[] = {-1, 1, 0, 0};
int dx[] = {0, 0, -1, 1};

int dy_horse[] = {-2, -2, -1, -1, 1, 1, 2, 2};
int dx_horse[] = {-1,  1, -2,  2,-2, 2,-1, 1};

void printv(int k) {
    
    for (int y = 0; y < H; y++) {
        for (int x = 0; x < W; x++) {
            cout << visited[y][x][k] << " ";
        }
        cout << "\n";
    }
    cout << "\n";
}

int bfs() {
    queue<Node> q;

    visited[0][0][K] = 1;
    q.push({0, 0, K, 0});
    while(!q.empty()) {
        Node curr = q.front(); q.pop();

        int y = curr.y;
        int x = curr.x;
        int k = curr.k;
        int dis = curr.dis;
        
        // cout << "(" << y << ", " << x << ")" "k: " << k << ", dis: " << dis << "\n";
        // printv(k);

        //격자판의 맨 왼쪽 위에서 시작해서 맨 오른쪽 아래까지 가야한다. 
        if (y == H - 1 && x == W - 1) {
            return dis;
        }

        if (k) {
            for (int dir = 0; dir < 8; dir++) {
                int ny = y + dy_horse[dir];
                int nx = x + dx_horse[dir];
                if (ny < 0 || ny >= H || nx < 0 || nx >= W)continue;
                if (myMap[ny][nx] == 1)continue;//장애물이 있는 곳으로는 이동할 수 없다. 
                if (visited[ny][nx][k - 1])continue;

                visited[ny][nx][k - 1] = 1;
                q.push({ny, nx, k - 1, dis + 1});
            }
        }

        for (int dir = 0; dir < 4; dir++) {
            int ny = y + dy[dir];
            int nx = x + dx[dir];
            if (ny < 0 || ny >= H || nx < 0 || nx >= W)continue;
            if (myMap[ny][nx] == 1)continue;//장애물이 있는 곳으로는 이동할 수 없다. 
            if (visited[ny][nx][k])continue;

            visited[ny][nx][k] = 1;
            q.push({ny, nx, k, dis + 1});
        }
    }
    return -1;
}

int main() {

    ios::sync_with_stdio(0); cin.tie(0);

    //첫째 줄에 정수 K가 주어진다. 둘째 줄에 격자판의 가로길이 W, 세로길이 H가 주어진다. 
    cin >> K;
    cin >> W >> H;

    /*
    그 다음 H줄에 걸쳐 W개의 숫자가 주어지는데, 
    0은 아무것도 없는 평지, 
    1은 장애물을 뜻한다. 
    */
    for (int y = 0; y < H; y++) {
        for (int x = 0; x < W; x++) {
            cin >> myMap[y][x];
        }
    }
    cout << bfs() << "\n";
    return 0;
}

/*
예제 입력 1 
1
4 4
0 0 0 0
1 0 0 0
0 0 1 0
0 1 0 0
예제 출력 1 
4


예제 입력 2 
2
5 2
0 0 1 1 0
0 0 1 1 0
예제 출력 2 
-1


1
4 4
0 0 0 0
1 0 0 0
0 0 1 1
0 1 1 0
*/