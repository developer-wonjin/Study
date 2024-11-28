#include <string>
#include <vector>
#include <iostream>

using namespace std;

/*
경주로 부지는 N x N 크기의 '정사각형' 격자 형태이며 각 격자는 1 x 1 크기입니다.
설계 도면에는 각 격자의 칸은 0 또는 1 로 채워져 있으며, 
0은 칸이 비어 있음을 
1은 해당 칸이 벽으로 채워져 있음

출발점은 (0, 0) 칸(좌측 상단)이며, 
도착점은 (N-1, N-1) 칸(우측 하단)입니다. 

중간에 끊기지 않도록 경주로를 건설해야 합니다.

경주로는 상, 하, 좌, 우로 인접한 두 빈 칸을 '연결'하여 건설할 수 있으며, 
(주의)벽이 있는 칸에는 경주로를 건설할 수 없습니다.

이때, 인접한 두 빈 칸을 상하 또는 좌우로 연결한 경주로를 직선 도로 라고 합니다.
또한 두 직선 도로가 서로 직각으로 만나는 지점을 코너 라고 부릅니다.

직선 도로 하나를 만들 때는 100원이 소요되며, 
코너를 하나 만들 때는 500원이 추가로 듭니다.

죠르디는 견적서 작성을 위해 경주로를 건설하는 데 필요한 최소 비용을 계산해야 합니다.

예를 들어, 아래 그림은 직선 도로 6개와 코너 4개로 구성된 임의의 경주로 예시이며, 건설 비용은 6 x 100 + 4 x 500 = 2600원 입니다.
*/

int n, m;
vector<vector<int>> myMap;
int visited[26][26];
int answer = 987654321;
int dy[] = {-1, 0, 1, 0};
int dx[] = {0, 1, 0, -1};

void printV(vector<pair<int, int>> v) {
    for (auto& entry : v) cout << "(" << entry.first << "," << entry.second << ") -> ";
    cout << "\n";
}

void printCosts(vector<int> v) {
    for (auto& ele : v) cout << ele << " ";
    cout << "\n";
}

void dfs(vector<pair<int, int>>& currs, vector<int>& costs, int currDir) {
    // cout << "(" << curr.first << ", " << curr.second << ") currDir : " << currDir << "\n";
    pair<int, int> curr = currs[currs.size() - 1];
    if (curr.first == n-1 && curr.second == m-1) {
        int cost = 0;
        for (auto& ele : costs)cost+=ele;

        // cout << cost << " | ";
        // printV(currs);
        // printCosts(costs);
        answer = min(answer, cost);
        return;
    }    
    
    for (int dir=0; dir<4; dir++) {
        
        int ny = curr.first  + dy[dir];
        int nx = curr.second + dx[dir];
        
        int nextCost = 0;
        if (currDir == -1 || currDir == dir) nextCost = 100; // 직선도로
        else nextCost = 100 + 500; // 코너
        
        if (ny < 0 || ny >= n || nx < 0 || nx >= m) continue;//영역밖
        if (myMap[ny][nx] == 1) continue;//벽
        if (visited[ny][nx]) continue;//방문한적 있던 곳
        
        visited[ny][nx] = 1;
        currs.push_back({ny, nx});
        costs.push_back(nextCost);
        dfs(currs, costs, dir);
        costs.pop_back();
        currs.pop_back();
        visited[ny][nx] = 0;
        
    }
}

int solution(vector<vector<int>> board) {
    n = board.size();
    m = board[0].size();
    
    myMap = board;
    
    visited[0][0] = 1;

    vector<pair<int, int>> path;
    path.push_back({0, 0});
    vector<int> costs;
    costs.push_back(0);
    dfs(path, costs, -1);
        
    return answer;
}

int main() {
    
    cout << solution(
        {{0,0,0},{0,0,0},{0,0,0}}
    ) << "\n";

    return 0;
}