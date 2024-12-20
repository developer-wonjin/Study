// https://www.acmicpc.net/problem/7576

/*
하루가 지나면, 익은 토마토들의 인접한 곳에 있는 익지 않은 토마토들은 익은 토마토의 영향을 받아 익게 된다.

며칠이 지나면 다 익게 되는지, 그 최소 일수를 알고 싶어 한다.

토마토를 창고에 보관하는 격자모양의 상자들의 크기와 익은 토마토들과 익지 않은 토마토들의 정보가 주어졌을 때, 
며칠이 지나면 토마토들이 모두 익는지, 그 최소 일수를 구하는 프로그램을 작성하라. 
단, 상자의 일부 칸에는 토마토가 들어있지 않을 수도 있다.

입력

토마토가 하나 이상 있는 경우만 입력으로 주어진다.


*/

#include<bits/stdc++.h>
using namespace std;


int N, M;
int myMap[1000][1000];
int visited[1000][1000];
vector<pair<int, int>> initTomato;
int main() {
    /*
    첫 줄에는 상자의 크기를 나타내는 두 정수 M,N이 주어진다.
    
    M은 상자의 가로 칸의 수
    N은 상자의 세로 칸의 수

    단, 2 ≤ M,N ≤ 1,000 이다. 
    */
    cin >> M >> N;

    /*
    둘째 줄부터는 하나의 상자에 저장된 토마토들의 정보가 주어진다.
    즉, 둘째 줄부터 N개의 줄에는 상자에 담긴 토마토의 정보가 주어진다.
    하나의 줄에는 상자 가로줄에 들어있는 토마토의 상태가 M개의 정수로 주어진다. 

    정수  1은 익은 토마토, 
    정수  0은 익지 않은 토마토, 
    정수 -1은 토마토가 들어있지 않은 칸
    */

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < M; j++) {
            cin >> myMap[i][j];
            if(myMap[i][j] == 1) {
                initTomato.push_back({i, j});
            }
        }
    }


    queue<pair<int, int>> q;
    for(auto& p : initTomato) {
        visited[p.first][p.second] = 1;
        q.push({p});
    }

    int dy[4] = {-1, 0, 1, 0};
    int dx[4] = {0, 1, 0, -1};

    int ans = 0;

    
    while(q.size()) {

        // for (int i = 0; i < N; i++) {
        //     for (int j = 0; j < M; j++) {
        //         cout << visited[i][j] << " ";
        //     }
        //     cout << "\n";
        // }
        // cout << "\n";

        auto& curr = q.front(); q.pop();
        ans = visited[curr.first][curr.second];

        for (int dir = 0; dir < 4; dir++) {
            int ny = curr.first + dy[dir];
            int nx = curr.second + dx[dir];

            if (ny < 0 || ny >= N || nx < 0 || nx >= M)continue;
            if (myMap[ny][nx] == -1)continue;
            if (visited[ny][nx]) continue;

            visited[ny][nx] = visited[curr.first][curr.second] + 1;
            myMap[ny][nx] = 1;
            q.push({ny, nx});
        }
    }

    int flag = 0;
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < M; j++) {
            if (myMap[i][j] == 0) {
                cout << "-1\n";
                return 0;
            }
        }
    }

    cout << ans - 1<< "\n";

/*
최소 날짜 : 토마토가 모두 익을 때까지
0        : 저장될 때부터 모든 토마토가 익어있는 상태
-1       : 토마토가 모두 익지는 못하는 상황
*/

    return 0;
}

/*
예제 입력 1 
6 4
0 0 0 0 0 0
0 0 0 0 0 0
0 0 0 0 0 0
0 0 0 0 0 1
예제 출력 1 
8


예제 입력 2 
6 4
0 -1 0 0 0 0
-1 0 0 0 0 0
0 0 0 0 0 0
0 0 0 0 0 1
예제 출력 2 
-1


예제 입력 3 
6 4
1 -1 0 0 0 0
0 -1 0 0 0 0
0 0 0 0 -1 0
0 0 0 0 -1 1
예제 출력 3 
6


예제 입력 4 
5 5
-1 1 0 0 0
0 -1 -1 -1 0
0 -1 -1 -1 0
0 -1 -1 -1 0
0 0 0 0 0
예제 출력 4 
14


예제 입력 5 
2 2
1 -1
-1 1
예제 출력 5 
0
*/