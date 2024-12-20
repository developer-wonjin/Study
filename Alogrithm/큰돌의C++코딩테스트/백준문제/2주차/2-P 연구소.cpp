// https://www.acmicpc.net/problem/14502

/*
연구소 성공
시간 제한	메모리 제한	제출	정답	맞힌 사람	정답 비율
2 초	512 MB	110258	63969	35847	55.306%
문제

연구소는 크기가 N×M인 직사각형으로 나타낼 수 있으며, 직사각형은 1×1 크기의 정사각형으로 나누어져 있다. 

빈 칸, 
벽

바이러스는 상하좌우로 인접한 빈 칸으로 모두 퍼져나갈 수 있다. 
새로 세울 수 있는 벽의 개수는 3개, 
꼭 3개를 세워야 한다.

예를 들어, 아래와 같이 연구소가 생긴 경우를 살펴보자.

2 0 0 0 1 1 0
0 0 1 0 1 2 0
0 1 1 0 1 0 0
0 1 0 0 0 0 0
0 0 0 0 0 1 1
0 1 0 0 0 0 0
0 1 0 0 0 0 0

0은 빈 칸, 
1은 벽, 
2는 바이러스

2행 1열, 1행 2열, 4행 6열에 벽을 세운다면 지도의 모양은 아래와 같아지게 된다.

2 1 0 0 1 1 0
1 0 1 0 1 2 0
0 1 1 0 1 0 0
0 1 0 0 0 1 0
0 0 0 0 0 1 1
0 1 0 0 0 0 0
0 1 0 0 0 0 0

바이러스가 퍼진 뒤의 모습은 아래와 같아진다.

2 1 0 0 1 1 2
1 0 1 0 1 2 2
0 1 1 0 1 2 2
0 1 0 0 0 1 2
0 0 0 0 0 1 1
0 1 0 0 0 0 0
0 1 0 0 0 0 0
벽을 3개 세운 뒤, 바이러스가 퍼질 수 없는 곳을 안전 영역이라고 한다. 위의 지도에서 안전 영역의 크기는 27이다.

안전 영역 크기의 최댓값을 구하는 프로그램을 작성하시오.


예제 입력 1 
7 7
2 0 0 0 1 1 0
0 0 1 0 1 2 0
0 1 1 0 1 0 0
0 1 0 0 0 0 0
0 0 0 0 0 1 1
0 1 0 0 0 0 0
0 1 0 0 0 0 0
예제 출력 1 
27
예제 입력 2 
4 6
0 0 0 0 0 0
1 0 0 0 0 2
1 1 1 0 0 2
0 0 0 0 0 2
예제 출력 2 
9
예제 입력 3 
8 8
2 0 0 0 0 0 0 2
2 0 0 0 0 0 0 2
2 0 0 0 0 0 0 2
2 0 0 0 0 0 0 2
2 0 0 0 0 0 0 2
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
예제 출력 3 
3
*/

#include<bits/stdc++.h>

using namespace std;


/*
입력
첫째 줄에 지도의 세로 크기 N과 가로 크기 M이 주어진다. (3 ≤ N, M ≤ 8)

둘째 줄부터 N개의 줄에 지도의 모양이 주어진다. 
0은 빈 칸, 
1은 벽, 
2는 바이러스가 있는 위치이다. 
2의 개수는 2보다 크거나 같고, 10보다 작거나 같은 자연수이다.

빈 칸의 개수는 3개 이상이다.

출력
첫째 줄에 얻을 수 있는 안전 영역의 최대 크기를 출력한다.
*/

int N, M;
vector<vector<int>> myMap(8, vector<int>(8, 0));
vector<pair<int, int>> emptyV, virus;

int dy[4] = {-1, 0, 1, 0};
int dx[4] = {0, 1, 0, -1};
int ans = 0;

int main() {

    ios::sync_with_stdio(0); cin.tie(0);
    cin >> N >> M;

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < M; j++) {
            cin >> myMap[i][j];
            if (myMap[i][j] == 0) emptyV.push_back({i, j});
            else if (myMap[i][j] == 2) virus.push_back({i, j});
        }
    }

    int emptyVN = emptyV.size();

    for (int i = 0; i < emptyVN; i++) {
        for (int j = i + 1; j < emptyVN; j++) {
            for (int k = j + 1; k < emptyVN; k++) {
                
                queue<pair<int, int>> q;
                vector<vector<int>> tmpMap = myMap;
                vector<vector<int>> visited(8, vector<int>(8, 0));
                
                // 벽을 세우자
                tmpMap[emptyV[i].first][emptyV[i].second] = 1;
                tmpMap[emptyV[j].first][emptyV[j].second] = 1;
                tmpMap[emptyV[k].first][emptyV[k].second] = 1;
                
                // 바이러스를 퍼트리자                 
                for (auto& ele : virus) {
                    visited[ele.first][ele.second] = 1;
                    tmpMap[ele.first][ele.second] = 2;
                    q.push(ele);
                }

                while (q.size()) {
                    pair<int, int> curr = q.front(); q.pop();

                    for (int dir = 0; dir < 4; dir++) {
                        int ny = curr.first + dy[dir];
                        int nx = curr.second + dx[dir];

                        if (ny < 0 || ny >= N || nx < 0 || nx >= M) continue;
                        if (tmpMap[ny][nx] == 1) continue;
                        if (visited[ny][nx])continue;

                        visited[ny][nx] = 1;
                        tmpMap[ny][nx] = 2;
                        q.push({ny, nx});
                    }
                }

                int tot = 0;
                for (int i = 0; i < N; i++) {
                    for (int j = 0; j < M; j++) {
                        if (tmpMap[i][j] == 0) tot++;
                    }
                }
                ans = max(ans, tot);
            }
        }
    }

    cout << ans << "\n";
    return 0;
}