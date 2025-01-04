// https://www.acmicpc.net/problem/2468

#include<bits/stdc++.h>

using namespace std;

/*
문제
먼저 어떤 지역의 높이 정보를 파악한다. 
그 다음에 그 지역에 많은 비가 내렸을 때 물에 잠기지 않는 안전한 영역이 최대로 몇 개가 만들어 지는 지를 조사하려고 한다. 

비의 양에 따라 일정한 높이 이하의 모든 지점은 물에 잠긴다

어떤 지역의 높이 정보는 행과 열의 크기가 각각 N
배열의 각 원소는 해당 지점의 높이를 표시 예를 들어, 다음은 N=5인 지역의 높이 정보이다.

6	8	2	6	2
3	2	3	4	6
6	7	3	3	2
7	2	5	3	6
8	9	5	2	7
이제 위와 같은 지역에 많은 비가 내려서 높이가 4 이하인 모든 지점이 물에 잠겼다고 하자. 이 경우에 물에 잠기는 지점을 회색으로 표시하면 다음과 같다.

6	8	2	6	2
3	2	3	4	6
6	7	3	3	2
7	2	5	3	6
8	9	5	2	7
물에 잠기지 않는 안전한 영역이라 함은 물에 잠기지 않는 지점들이 위, 아래, 오른쪽 혹은 왼쪽으로 인접해 있으며 그 크기가 최대인 영역을 말한다. 
위의 경우에서 물에 잠기지 않는 안전한 영역은 5개가 된다(꼭짓점으로만 붙어 있는 두 지점은 인접하지 않는다고 취급한다).

또한 위와 같은 지역에서 높이가 6이하인 지점을 모두 잠기게 만드는 많은 비가 내리면 물에 잠기지 않는 안전한 영역은 아래 그림에서와 같이 네 개가 됨을 확인할 수 있다.

6	8	2	6	2
3	2	3	4	6
6	7	3	3	2
7	2	5	3	6
8	9	5	2	7

(중요) 비의 양에 따라서 물에 잠기지 않는 안전한 영역의 개수는 다르게 된다. 

비의 양에 따른 모든 경우를 다 조사해 보면 물에 잠기지 않는 안전한 영역의 개수 중에서 최대인 경우는 5임을 알 수 있다.

어떤 지역의 높이 정보가 주어졌을 때, 장마철에 물에 잠기지 않는 안전한 영역의 최대 개수를 계산하는 프로그램을 작성하시오.

입력
첫째 줄에는 어떤 지역을 나타내는 2차원 배열의 행과 열의 개수를 나타내는 수 N이 입력된다. 
N은 2 이상 100 이하의 정수이다. 

둘째 줄부터 N개의 각 줄에는 2차원 배열의 첫 번째 행부터 N번째 행까지 순서대로 한 행씩 높이 정보가 입력된다. 
각 줄에는 각 행의 첫 번째 열부터 N번째 열까지 N개의 높이 정보를 나타내는 자연수가 빈 칸을 사이에 두고 입력된다. 
높이는 1이상 100 이하의 정수이다.

출력
첫째 줄에 장마철에 물에 잠기지 않는 안전한 영역의 최대 개수를 출력한다.
*/

int N;
int myMap[100][100];
int visited[100][100];

int maxH = 1;
int minH = 101;
int ans = 1;

int dy[4] = {-1, 0, 1, 0};
int dx[4] = {0, -1, 0, 1};

void init() {

    for (int i = 0; i < 100; i++) {
        fill(visited[i], visited[i] + 100, 0);
    }
}

void dfs (int y, int x, int rain) {
    visited[y][x] = 1;

    for (int dir = 0; dir < 4; dir++) {
        int ny = y + dy[dir];
        int nx = x + dx[dir];

        if (ny < 0 || ny >= N || nx < 0 || nx >= N) continue;
        if (myMap[ny][nx] - rain <= 0) continue;
        if (visited[ny][nx]) continue;

        dfs(ny, nx, rain);
    }
}

int main(){

    ios::sync_with_stdio(0); cin.tie(0);

    cin >> N;

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            cin >> myMap[i][j];
            maxH = max(maxH, myMap[i][j]);
            minH = min(minH, myMap[i][j]);
        }
    }
    
    for (int rain = minH; rain < maxH; rain++) {
        init();

        int safeCnt = 0;
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                
                if (myMap[i][j] - rain <= 0) continue;
                if (visited[i][j]) continue;

                safeCnt++;
                dfs(i, j, rain);
            }
        }

        ans = max(ans, safeCnt);

        // cout << "ans: " << ans << "\n";
    }

    cout << ans;
    return 0;
}