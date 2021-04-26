# 1926 그림

```c
if (myMap[nextY][nextX] == 0 || visited[nextY][nextX]) continue;
```

| `myMap[i][j]` | `myMap[i][j]` == 0 | `visited[i][j]` | and  | **or** |
| ------------- | ------------------ | --------------- | :--- | ------ |
| 0 일경우      | true               | false           | F    | **T**  |
| 1 일 경우     | false              | true            | F    | **T**  |
| 1 일 경우     | false              | false           | F    | **F**  |

따라서 OR가 정답임



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



# 2178 미로 탐색

주의 

```c
			if (myMap[nextY][nextX] == 0) continue;
			if (visited[nextY][nextX])continue;
```

두 조건은  or로 묶어야함 .  &&조건이 아님.

```c
if (myMap[nextY][nextX] == 0 || visited[nextY][nextX]) continue;
```

| `myMap[i][j]` | `myMap[i][j]` == 0 | `visited[i][j]` | and  | **or** |
| ------------- | ------------------ | --------------- | :--- | ------ |
| 0 일경우      | true               | false           | F    | **T**  |
| 1 일 경우     | false              | true            | F    | **T**  |
| 1 일 경우     | false              | false           | F    | **F**  |



주의

입력이 문자열이면 숫자로 변형하기 위해 '0' 빼는거 주의할 것.

```c
myMap[i][j] = s[j]-'0';
```



```c
#include<queue>
#include<iostream>
#include<utility>

#define Y first
#define X second

using namespace std;

const int MAX = 101;

struct Node {
	int y;
	int x;
	int cnt;
};
queue<Node> Queue;
int myMap[MAX][MAX];
Node myNode[MAX][MAX];
bool visited[MAX][MAX];
int n, m;

int dy[4] = {0,-1,0,1};
int dx[4] = {1,0,-1,0};

void BFS() {
	visited[0][0] = true;
	Queue.push({ 0,0,1 });

	while (!Queue.empty()) {

		Node curr = Queue.front(); Queue.pop();

		if (curr.y == n - 1 && curr.x == m - 1)cout << curr.cnt;

		/*cout << "(" << curr.y << ", " << curr.x << ")->";*/

		for (int dir = 0; dir < 4; dir++) {
			int nextY = curr.y + dy[dir];
			int nextX = curr.x + dx[dir];

			if (nextY < 0 || nextY >= n || nextX < 0 || nextX >= m)continue;
			if (myMap[nextY][nextX] == 0) continue;
			if (visited[nextY][nextX])continue;

			/*if (nextY == 0 && nextX == 1) {
				cout << "myMap[nextY][nextX]: " << myMap[nextY][nextX] << endl;
				cout << "visited[nextY][nextX]: " << visited[nextY][nextX] << endl;
			}*/

			//cout << "(" << nextY << ", " << nextX << ")->";

			visited[nextY][nextX] = true;
			Node nextNode = { nextY, nextX, curr.cnt + 1 };
			Queue.push(nextNode);
		}

	}
}


int main(void) {
	ios::sync_with_stdio(0);
	cin.tie(0);

	string s;

	cin >> n >> m;

	for (int i = 0; i < n; i++) {
		cin >> s;

		for (int j = 0; j < m; j++) {
			myMap[i][j] = s[j]-'0';
		}
	}

	BFS();

	return 0;
}
```



# 7576 토마토 

```c
#include<queue>
#include<iostream>
#include<utility>

#define Y first
#define X second

using namespace std;

const int MAX = 1000;
int myMap[MAX][MAX];
int visited[MAX][MAX];
int n, m;
int dy[4] = {0,-1,0,1};
int dx[4] = {1,0,-1,0};
int day = 0;
int notMature = 0;
struct Node {
	int y;
	int x;
	int day;
};

queue<Node> Queue;

void BFS() {

	while (!Queue.empty()) {
		Node curr = Queue.front(); Queue.pop();

		day = curr.day;

		for (int dir = 0; dir < 4; dir++) {
			int nextY = curr.y + dy[dir];
			int nextX = curr.x + dx[dir];

			if (nextY < 0 || nextY >= n || nextX < 0 || nextX >= m)continue;
			if (myMap[nextY][nextX] == -1 || visited[nextY][nextX])continue;

			visited[nextY][nextX] = true;
			Queue.push({ nextY, nextX, day + 1 });
			myMap[nextY][nextX] = 1;

		}
	}
}

bool searchNotMatureToma() {
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < m; j++) {
			if (myMap[i][j] == 0)return true;
		}
	}
	return false;
}

int main(void) {
	ios::sync_with_stdio(0);
	cin.tie(0);
	
	cin >> m >> n;

	for (int i = 0; i < n; i++) {
		for (int j = 0; j < m; j++) {
			cin >> myMap[i][j];
			if (myMap[i][j] == 0)notMature++;
			if (myMap[i][j] == 1) {
				visited[i][j] = true;
				Queue.push({ i, j, 0 });
			}
		}
	}

	if (notMature) {
		BFS();
		bool isExistNotMature = searchNotMatureToma();

		if (isExistNotMature) {
			cout << -1;
		}
		else {
			cout << day;
		}

	}
	else {
		cout << 0;
	}

	return 0;
}
```



# 4179 [ 불!](https://www.acmicpc.net/problem/4179) 

```c
#include<iostream>
#include<queue>

using namespace std;

const int MAX = 1001;

char myGraph[MAX][MAX];

//맵에 . 표기된 곳만 따라가면 되기 때문에 visited 필요없음
//bool visited_j[MAX][MAX];

//맵에 표기된 'F'가 visited체크를 대신할 수 있다.
//bool visited_f[MAX][MAX];


const char JIHUN = 'J';
const char FIRE = 'F';

struct Node {
	int y;
	int x;
	int type;
	int time;
};

queue<Node> Queue;

int R, C;

int dy[4] = { 0, -1, 0, 1 };
int dx[4] = { 1,0,-1,0 };

void drawGraph() {
	for (int i = 0; i < R; i++) {
		for (int j = 0; j < C; j++) {
			cout << myGraph[i][j] << ' ';
		}
		cout << '\n';
	}
	cout << '\n';
	cout << '\n';
}

int BFS() {
	//drawGraph();

	while (!Queue.empty()) {
		Node curr = Queue.front(); Queue.pop();

		if (curr.type == 'J' && myGraph[curr.y][curr.x] == 'F') {
			//다음 지훈이의 상태라고 생각하여 PUSH했으나
			//불에의해 나중에 F인 상태로 변한 경우의 NODE는 무시한다.
			continue;
		}



		for (int dir = 0; dir < 4; dir++) {
			int nextY = curr.y + dy[dir];
			int nextX = curr.x + dx[dir];

			if (curr.type == 'J' && myGraph[curr.y][curr.x] == 'J' && (curr.y == 0 || curr.y == R-1 || curr.x == 0 || curr.x == C-1)) {
				return curr.time + 1;
			}

			if (nextY < 0 || nextY >= R || nextX < 0 || nextX >= C) continue;
			if (myGraph[nextY][nextX] == '#')continue;

			if (curr.type == 'J' && myGraph[nextY][nextX] == '.') {
				myGraph[nextY][nextX] = 'J';
				Queue.push({ nextY, nextX, curr.type, curr.time + 1 });
				//drawGraph();
			}
			else if (curr.type == 'F' && myGraph[nextY][nextX] != 'F') {
				myGraph[nextY][nextX] = 'F';
				Queue.push({ nextY, nextX, curr.type, curr.time + 1 });
				//drawGraph();
			}
		}
	}
	return -1;
}

int main(void) {
	ios::sync_with_stdio(0);
	cin.tie(0);

	cin >> R >> C;

	for (int i = 0; i < R; i++) {
		for (int j = 0; j < C; j++) {
			char t;
			cin >> t;
			myGraph[i][j] = t;
			if (t == 'J') {
				Queue.push({ i, j, JIHUN, 0 });
			}
			if (t == 'F') {
				Queue.push({ i,j,FIRE, 0 });
			}
		}
	}

	int res = BFS();

	if (res > 0) {
		cout << res;
	}
	else if(res == -1) {
		cout << "IMPOSSIBLE";
	}

	return 0;
}

/*
4 4
####
#JF#
#..#
#..#

3 4
####
#J.#
#.F#

*/
```



다른사람 풀이

```c
#include <bits/stdc++.h>
using namespace std;

char arr[1000][1001];
int dr[] = {1,-1,0,0}, dc[] = {0,0,1,-1};
int R, C;
bool ok(int i, int j) {
	return 0 <= i && i < R && 0 <= j && j < C;
}
int main() {
	ios::sync_with_stdio(0);cin.tie(0);
	cin >> R >> C;
	for(int i=0; i<R; i++) {
		cin >> arr[i];
	}
	queue<pair<int, int>> fire, me;
	for(int i=0; i<R; i++) {
		for(int j=0; j<C; j++) {
			if(arr[i][j] == 'J') me.push({i,j});
			else if(arr[i][j] == 'F') fire.push({i,j});
		}
	}
	int t = 0;
	while(++t) {
		int s = fire.size();
		while(s--) {
			int r, c;
			tie(r, c) = fire.front();
			fire.pop();
			for(int i=0; i<4; i++) {
				int tr = r+dr[i], tc = c+dc[i];
				if(!ok(tr, tc) || arr[tr][tc] == 'F' || arr[tr][tc] == '#') continue;
				arr[tr][tc] = 'F';
				fire.push({tr, tc});
			}
		}
		s = me.size();
		while(s--) {
			int r, c;
			tie(r, c) = me.front();
			me.pop();
			for(int i=0; i<4; i++) {
				int tr = r+dr[i], tc = c+dc[i];
				if(!ok(tr, tc)) return !(cout << t);
				if(arr[tr][tc] == 'F' || arr[tr][tc] == '#' || arr[tr][tc] == 'J') continue;
				arr[tr][tc] = 'J';
				me.push({tr, tc});
			}
		}
		if(!me.size())
			return !(cout << "IMPOSSIBLE");
	}
}
```



다른사람풀이

```c
#include<bits/stdc++.h>

using namespace std;

const int MAX = 1000;

char myMap[MAX][MAX];

int R, C;

queue<pair<int, int>> j_q, f_q;

int dy[4] = { -1, 1, 0, 0 };
int dx[4] = { 0, 0, -1, 1 };

int ans[MAX][MAX];

void printMap() {
	for (int i = 0; i < R; i++) {
		for (int j = 0; j < C; j++) {
			cout << myMap[i][j] << ' ';
		}
		cout << '\n';
	}
	cout << '\n';

}

bool BFS() {
	//printMap();
	while (!j_q.empty()) {//queue에 push된 이동가능한 지훈element가 더 이상 없을 때까지
		for (int f = 0; f < f_q.size(); f++) { //무한반복 while이 아닌 유한으로 최외각 둘레만 BFS한다.
			pair<int, int> fcurr = f_q.front(); f_q.pop();
			
			for (int dir = 0; dir < 4; dir++) {
				int fnextY = fcurr.first  + dy[dir];
				int fnextX = fcurr.second + dx[dir];
				//cout << "(" << fnextY << "," << fnextX << ")->";
				if (fnextY < 0 || fnextY >= R || fnextX < 0 || fnextX >= C)continue; //경계밖

				if (myMap[fnextY][fnextX] == '.') {
					myMap[fnextY][fnextX] = 'F';
					f_q.push({ fnextY, fnextX });
				}
			}
		}

		for (int j = 0; j < j_q.size(); j++) {// 최외각 둘레만 BFS한다.
			pair<int, int> jcurr = j_q.front(); j_q.pop();

			for (int dir = 0; dir < 4; dir++) {
				int jnextY = jcurr.first + dy[dir];
				int jnextX = jcurr.second + dx[dir];

				if (jnextY < 0 || jnextY >= R || jnextX < 0 || jnextX >= C) {
					cout << ans[jcurr.first][jcurr.second] + 1;
					return true;
				}

				if (myMap[jnextY][jnextX] == '.') {
					myMap[jnextY][jnextX] = 'J';
					ans[jnextY][jnextX] = ans[jcurr.first][jcurr.second] + 1;
					j_q.push({ jnextY, jnextX });
				}
			}
		}
		//printMap();
	}
	return false;
}

int main(void) {
	ios::sync_with_stdio(0);
	cin.tie(0);

	cin >> R >> C;

	for (int i = 0; i < R; i++) {
		for (int j = 0; j < C; j++) {
			cin >> myMap[i][j];
			if (myMap[i][j] == 'J') {
				j_q.push(make_pair(i, j));
			}

			if (myMap[i][j] == 'F') {
				f_q.push(make_pair(i, j));
			}
		}
	}

	if (!BFS()) {
		cout << "IMPOSSIBLE";
	}

	return 0;
}
```



# 1697 숨박꼭질

```c

```



