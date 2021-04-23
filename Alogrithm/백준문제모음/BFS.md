# 1926

```c
#include<utility>
#include<iostream>
#include<vector>
#include<queue>
#include<algorithm>
#define Y first
#define X second

using namespace std;

const int MAX = 501;

int n, m;

int myMap[MAX][MAX];
bool visited[MAX][MAX];

int dy[4] = { 0, -1,  0,  1 };
int dx[4] = { 1,  0, -1,  0 };

int cnt = 0;
int maxArea = -1;

void BFS(int y, int x) {
	queue<pair<int, int>> Queue;
	int area = 0;
	
	visited[y][x] = true;
	Queue.push({ y,x });

	while (!Queue.empty()) {
		pair<int, int> curr = Queue.front(); Queue.pop();

		area++;

		for (int dir = 0; dir < 4; dir++) {
			int nextY = curr.Y + dy[dir];
			int nextX = curr.X + dx[dir];

			if (nextY < 0 || nextY >= n || nextX < 0 || nextX >= m)continue;
			if (myMap[nextY][nextX] == 0 || visited[nextY][nextX]) continue;
			//cout << '(' << nextY << ',' << nextX << ") -> ";
			visited[nextY][nextX] = true;
			Queue.push({ nextY , nextX });
		}
	}
	//cout << '\n';

	maxArea = max(maxArea, area);
}

int main(void) {
	ios::sync_with_stdio(0);
	cin.tie(0);


	cin >> n >> m;

	for (int y = 0; y < n; y++) {
		for (int x = 0; x < m; x++) {
			cin >> myMap[y][x];
		}
	}

	//cout << '\n';cout << '\n';

	//for (int y = 0; y < n; y++) {
	//	for (int x = 0; x < m; x++) {
	//		cout << myMap[y][x] << ' ';
	//	}
	//	cout << '\n';
	//}


	for (int y = 0; y < n; y++) {
		for (int x = 0; x < m; x++) {
			//방문한 적 없었고 
			//1이면
			if (!visited[y][x] && myMap[y][x] == 1) {
				BFS(y, x);
				cnt++;
			}
		}
	}

	if (cnt == 0) {
		maxArea = 0;
	}

	cout << cnt << '\n';
	cout << maxArea;

}
```

