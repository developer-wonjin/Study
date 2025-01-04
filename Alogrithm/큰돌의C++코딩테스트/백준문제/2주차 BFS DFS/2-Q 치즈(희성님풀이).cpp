// https://www.acmicpc.net/problem/2636
/*
치즈
시간 제한	메모리 제한	제출	정답	맞힌 사람	정답 비율
1 초	128 MB	33900	19200	13710	55.448%
문제
아래 <그림 1>과 같이 정사각형 칸들로 이루어진 사각형 모양의 판이 있고, 
치즈 : 회색
판의 가장자리(<그림 1>에서 네모 칸에 X친 부분)에는 치즈가 놓여 있지 않으며 치즈에는 하나 이상의 구멍이 있을 수 있다.
공기와 접촉된 칸은 '한 시간'이 지나면 녹아 없어진다.
치즈의 구멍 속에는 공기가 없지만 구멍을 둘러싼 치즈가 녹아서 '구멍이 열리면 구멍 속으로 공기가 들어가게 된다'
<그림 1>의 경우, 치즈의 구멍을 둘러싼 치즈는 녹지 않고 ‘c’로 표시된 부분만 한 시간 후에 녹아 없어져서 <그림 2>와 같이 된다.
<그림 3>은 원래 치즈의 두 시간 후 모양을 나타내고 있으며, 남은 조각들은 한 시간이 더 지나면 모두 녹아 없어진다. 그러므로 처음 치즈가 모두 녹아 없어지는 데는 세 시간이 걸린다. <그림 3>과 같이 치즈가 녹는 과정에서 여러 조각으로 나누어 질 수도 있다.
입력으로 사각형 모양의 판의 크기와 한 조각의 치즈가 판 위에 주어졌을 때, 
시간: 공기 중에서 치즈가 모두 녹아 없어지는 데 걸리는 시간 
칸 갯수: 모두 녹기 한 시간 전에 남아있는 치즈조각이 놓여 있는 칸
입력
첫째 줄에는 사각형 모양 판의 세로와 가로의 길이가 양의 정수로 주어진다. 
세로와 가로의 길이는 최대 100이다. 
판의 각 가로줄의 모양이 윗 줄부터 차례로 둘째 줄부터 마지막 줄까지 주어진다. 
치즈가 없는 칸은 0,
치즈가 있는 칸은 1
출력
첫째 줄에는 치즈가 모두 녹아서 없어지는 데 걸리는 시간을 출력하고, 둘째 줄에는 모두 녹기 한 시간 전에 남아있는 치즈조각이 놓여 있는 칸의 개수를 출력한다.
예제 입력 1 
13 12
0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 1 1 0 0 0
0 1 1 1 0 0 0 1 1 0 0 0
0 1 1 1 1 1 1 0 0 0 0 0
0 1 1 1 1 1 0 1 1 0 0 0
0 1 1 1 1 0 0 1 1 0 0 0
0 0 1 1 0 0 0 1 1 0 0 0
0 0 1 1 1 1 1 1 1 0 0 0
0 0 1 1 1 1 1 1 1 0 0 0
0 0 1 1 1 1 1 1 1 0 0 0
0 0 1 1 1 1 1 1 1 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0
예제 출력 1 
3
5

4 4
0 0 0 0
0 0 0 0
0 0 0 0
0 0 0 0
예제 출력 2
0
0
*/
# include<bits/stdc++.h>
using namespace std;
int n, m;
const int NMAX = 100;
const int MMAX = 100;
vector<vector<int>> myMap(NMAX, vector<int>(MMAX, 0));
int dy[4] = {-1, 0, 1, 0};
int dx[4] = {0, 1, 0, -1};
int main() {
    ios::sync_with_stdio(0);cin.tie(0);
    cin >> n >> m;
    int currCheeze = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            cin >> myMap[i][j];
            currCheeze += myMap[i][j];
        }
    }
    int t = 0;
    int beforeCheeze = 0;
    while(currCheeze) {
        // 녹이자
        vector<pair<int,int>> meltList;
        queue<pair<int, int>> q;
        vector<vector<int>> visited(n, vector<int>(m, 0));
        // 공기를 BFS하자
        visited[0][0] = 1;
        q.push({0, 0});
        while(q.size()) {
            pair<int, int> curr = q.front(); q.pop();
            int y = curr.first;
            int x = curr.second;
            for (int dir = 0; dir < 4; dir++) {
                int ny = y + dy[dir];
                int nx = x + dx[dir];
                if (ny < 0 || ny >= n || nx < 0 || nx >= m)continue;
                if (myMap[ny][nx] == 1) {
                    meltList.push_back({ny, nx});
                    continue; // 공기만 bfs할꺼임
                } 
                if (visited[ny][nx]) continue;
                visited[ny][nx] = 1;
                q.push({ny, nx});
            }
        }
        for (auto& pos : meltList) myMap[pos.first][pos.second] = 0;
        // for (int i = 0; i < n; i++) {
        //     for (int j = 0; j < m; j++) {
        //         cout << myMap[i][j] << " ";
        //     }
        //     cout << "\n";
        // }
        // cout << "\n";
        // cout << "\n";
            
        t++;
        // 녹은후 현재 currCheeze갯수 재산출
        beforeCheeze = currCheeze;
        currCheeze = 0;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++){
                if (myMap[i][j]) currCheeze++;
            }
        }

    }
    cout << t << "\n";
    cout << beforeCheeze << "\n";
    return 0;
}