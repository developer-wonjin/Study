 // https://www.acmicpc.net/problem/2583
#include<bits/stdc++.h>

using namespace std;

/*
문제
M×N(M,N≤100)크기
K개의 직사각형을 그릴 때, 
내부를 제외한 나머지 부분이 몇 개의 분리된 영역으로 나누어진다.

예를 들어 M=5, N=7 인 모눈종이 위에 <그림 1>과 같이 직사각형 3개를 그렸다면, 
그 나머지 영역은 <그림 2>와 같이 3개의 분리된 영역으로 나누어지게 된다.

<그림 2>와 같이 분리된 세 영역의 넓이는 각각 1, 7, 13이 된다.

M, N과 K 그리고 
K개의 직사각형의 좌표가 주어질 때, 

K개의 직사각형 내부를 제외한 나머지 부분이 몇 개의 분리된 영역으로 나누어지는지, 
그리고 분리된 각 영역의 넓이가 얼마인지를 구하여 이를 출력하는 프로그램을 작성하시오.

입력
첫째 줄에 M과 N, 그리고 K가 빈칸을 사이에 두고 차례로 주어진다. 
M, N, K는 모두 100 이하의 자연수이다. 

둘째 줄부터 K개의 줄에는 한 줄에 하나씩 직사각형의 
왼쪽 아래 꼭짓점의 x, y좌표값과 
오른쪽 위 꼭짓점의 x, y좌표값이 빈칸을 사이에 두고 차례로 주어진다. 
모눈종이의 왼쪽 아래 꼭짓점의 좌표는 (0,0)이고, 
오른쪽 위 꼭짓점의 좌표는(N,M)이다. 

입력되는 K개의 직사각형들이 모눈종이 전체를 채우는 경우는 없다.

출력
첫째 줄에 분리되어 나누어지는 영역의 개수를 출력한다. 
둘째 줄에는 각 영역의 넓이를 오름차순으로 정렬하여 빈칸을 사이에 두고 출력한다.
*/

int myMap[101][101];
int visited[101][101];
int N, M, K;

void init() {
    while(K--) {
        int lx,ly,  rx,ry;
        cin >> lx >> ly >>  rx >> ry;

        for (int x = lx; x < rx; x++) {
            for (int y = ly; y < ry; y++) {
                myMap[x][y] = 1;
            }
        }
    }

}

int dy[4] = {-1, 0, 1, 0};
int dx[4] = {0, 1, 0, -1};
int visitFlag = 0;

void printVisited() {
    for (int y = M-1; y >= 0; y--) {
        for (int x = 0; x < N; x++) {
            if (visited[x][y] >= 10) {
                cout << visited[x][y] << " ";
            } else {
                cout << "0" + to_string(visited[x][y]) << " ";
            }
        }
        cout << "\n";
    }
}

int dfs(int x, int y) {
    // cout << "\n\n(" << x << ", " << y << ")\n";
    // printVisited();

    int cnt = 1; // 나 자신

    for (int dir = 0; dir < 4; dir++){
        int nx = x + dx[dir];
        int ny = y + dy[dir];

        if (nx < 0 || nx >= N || ny < 0 || ny >= M)continue;
        if (myMap[nx][ny]) continue;
        if (visited[nx][ny]) continue;

        // visited[nx][ny] = visited[x][y] + 1;
        visited[nx][ny] = visitFlag;
        cnt += dfs(nx, ny); // 주변
    }
    return cnt;
}


int main(){
    ios::sync_with_stdio(0); cin.tie(0);

    cin >> M >> N >> K;
    

    init();

    // cout << "\n";
    // for (int y = M-1; y >= 0; y--) {
    //     for (int x = 0; x <= N; x++) cout << myMap[x][y] << " ";
    //     cout << "\n";
    // }

    vector<int> area;
    for (int y = 0; y < M; y++) {
        for (int x = 0; x < N; x++) {
            if (myMap[x][y] == 1) continue;
            if (visited[x][y]) continue;
            visitFlag++;
            visited[x][y] = visitFlag;
            area.push_back(dfs(x, y));

        }
    }

    sort(area.begin(), area.end());
    cout << area.size() << "\n";
    for (auto& ele : area) cout << ele << " ";
    cout << "\n";

    return 0;
}