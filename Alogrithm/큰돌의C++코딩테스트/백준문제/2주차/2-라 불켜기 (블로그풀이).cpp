#include <iostream>
#include <queue>
#include <vector>
using namespace std;

struct xy {int x, y;};
int N, M;
bool lights[101][101];
bool vis[101][101];
vector<xy> btns[101][101];
int dx[] = {1, 0, -1, 0};
int dy[] = {0, 1, 0, -1};

void printV() {
    for (int i = 1; i <= N; i++) {
        for (int j = 1; j <= N; j++) {
            cout << vis[i][j] << " ";
        }
        cout << "\n";
    }
    cout << "\n";
}

int main() {
    ios::sync_with_stdio(0);
    cin.tie(0);
    cin >> N >> M;
    while(M--) {
        int x, y, a, b;
        cin >> x >> y >> a >> b;
        btns[x][y].push_back({a, b});
    }
    queue<xy> Q;
    int cnt = 1;
    lights[1][1] = true;
    vis[1][1] = true;
    Q.push({1, 1});
    while(!Q.empty()) {

        printV();

        xy cur = Q.front(); Q.pop();
        auto &curBtns = btns[cur.x][cur.y];
        while(!curBtns.empty()) {
            const xy btn = curBtns.back(); curBtns.pop_back();
            int x = btn.x;
            int y = btn.y;

            if (lights[x][y]) continue;
            
            cnt++;
            lights[x][y] = true; 
            
            for(int i=4; i--;) {
                int nx = x + dx[i], ny = y + dy[i];
                if(nx<1 || nx>N || ny<1 || ny>N) continue;
                if(vis[nx][ny]) {
                    vis[x][y] = true;
                    Q.push({x,y});
                    break;
                }
            }
        }
        for(int i=4; i--;) {
            int nx = cur.x + dx[i], ny = cur.y + dy[i];
            if(nx<1 || nx>N || ny<1 || ny>N) continue;
            if(vis[nx][ny] || !lights[nx][ny]) continue;
            vis[nx][ny] = true;
            Q.push({nx, ny});
        }
    }
    cout << cnt;
}