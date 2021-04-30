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
#include<bits/stdc++.h>

using namespace std;

queue<pair<int, int>> Queue; //위치, depth

int N, K;
int MAX = 100000;
bool visited[100001];

void BFS() {

	while (!Queue.empty()) {
		
		pair<int, int> curr = Queue.front(); Queue.pop();

		int pos = curr.first;
		int depth = curr.second;

		if (pos == K) {
			cout << depth;
			return;
		}

		int nextPos;
		int nextDepth = depth + 1;
		
		//+1
		nextPos = pos + 1;
		if (0 <= nextPos && nextPos <= MAX && !visited[nextPos]) {
			Queue.push(make_pair(nextPos, nextDepth));
			visited[nextPos] = true;
		}
		//-1
		nextPos = pos - 1;
		if (0 <= nextPos && nextPos <= MAX && !visited[nextPos]) {
			Queue.push(make_pair(nextPos, nextDepth));
			visited[nextPos] = true;
		}
			
		//*2
		nextPos = pos * 2;
		if (0 <= nextPos && nextPos <= MAX && !visited[nextPos]) {
			Queue.push(make_pair(nextPos, nextDepth));
			visited[nextPos] = true;
		}
	}
}

int main() {
	ios::sync_with_stdio(0);
	cin.tie(0);

	cin >> N >> K;

	visited[N] = true;
	Queue.push(make_pair(N, 0));

	BFS();

	return 0;
}
```



# 유기농배추

```c
#include<bits/stdc++.h>

using namespace std;

int T;
int M, N, K;
const int MAX = 50;



queue<pair<int, int>> Q;

int dy[4] = { -1, 1, 0, 0 };
int dx[4] = { 0, 0, -1, 1 };

void BFS(int myMap[][MAX], bool visited[][MAX]) {
	while (!Q.empty()) {
		pair<int, int> curr = Q.front(); Q.pop();

		for (int dir = 0; dir < 4; dir++) {

			int nextY = curr.first + dy[dir];
			int nextX = curr.second+ dx[dir];

			if (nextY < 0 || nextY >= M || nextX < 0 || nextX >= N)continue;

			if (myMap[nextY][nextX] == 1 && !visited[nextY][nextX]) {
				visited[nextY][nextX] = true;
				Q.push({ nextY, nextX });
			}

		}



	}
}

int main(void) {
	ios::sync_with_stdio(0);
	cin.tie(0);

	cin >> T;

	for (int i = 0; i < T; i++) {
		int myMap[MAX][MAX] = { 0, };
		bool visited[MAX][MAX] = { 0, };
		int ans = 0;
		/*for (int j = 0; j < MAX; j++) {
			fill(myMap[i], myMap[i] + MAX, 0);
		}*/
		
		cin >> M >> N >> K;
		
		for (int j = 0; j < K; j++) {
			int r, c;
			cin >> r >> c;
			myMap[r][c] = 1;
		}


		for (int r = 0; r < MAX; r++) {
			for (int c = 0; c < MAX; c++) {
				if (!visited[r][c] && myMap[r][c] == 1) {
					//cout << "(" << r << "," << c << ") ";
					ans++;
					visited[r][c] = true;
					Q.push({ r,c });
					BFS(myMap, visited);
				}
			}
		}

		cout << ans << '\n';

	}

	return 0;
}
```



# 7569 토마토(3차원)

```c
#include<bits/stdc++.h>

using namespace std;


const int MAX = 100;
int M, N, H;

int mymap[MAX][MAX][MAX];
bool visited[MAX][MAX][MAX];
struct node {
	int y;
	int x;
	int z;
};
queue<node> Q;

int tot_not_mature;
int cnt_be_mature;
int mytime = 0;

int dy[6] = {-1,1,0,0,0,0};
int dx[6] = {0,0,-1,1,0,0};
int dz[6] = {0,0,0,0,-1,1};

void printMap() {
	cout << '\n';
	for (int k = 0; k < H; k++) {
		for (int j = 0; j < N; j++) {
			for (int i = 0; i < M; i++) {
				cout << mymap[i][j][k] << '\t';
			}
			cout << '\n';
		}
		cout << '\n';
	}
	
}

void BFS() {
	//printMap();
	while (!Q.empty()) {
		//cout << "\nQ의 요소갯수: " << Q.size() << '\n';
		int qsize = Q.size();

		int flag = false;

		for (int i = 0; i < qsize; i++) {
			node curr = Q.front(); Q.pop();
			//cout << "\n\n[(" << curr.y << "," << curr.x << ") 리스트 " << i << "]    ";
			for (int dir = 0; dir < 6; dir++) {
				int nextY = curr.y + dy[dir];
				int nextX = curr.x + dx[dir];
				int nextZ = curr.z + dz[dir];

				if (nextY < 0 || nextY >= M || nextX < 0 || nextX >= N || nextZ < 0 || nextZ >= H)continue;
				if (mymap[nextY][nextX][nextZ] == 0) {
					
					//cout << "(" << nextY << "," << nextX << ") -> ";

					Q.push({ nextY , nextX, nextZ });
					mymap[nextY][nextX][nextZ] = 1;
					flag = true;
					cnt_be_mature++;
				}
			}
		}
		//printMap();
		if(flag)mytime++;
		//cout << "mytime: " << mytime << '\n';
	}

	if (cnt_be_mature == tot_not_mature) {
		cout << mytime;

	}
	else {
		cout << -1;
	}
}



int main(void) {
	ios::sync_with_stdio(0);
	cin.tie(0);


	cin >> M >> N >> H;

	for (int k = 0; k < H; k++) {
		for (int j = 0; j < N; j++) {
			for (int i = 0; i < M; i++) {
				cin >> mymap[i][j][k];
				if (mymap[i][j][k] == 0)tot_not_mature++;
				if (mymap[i][j][k] == 1)Q.push({ i,j,k });
			}
		}
	}




	BFS();

	return 0;
}
```



# 2583 영역구하기

```c
#include<bits/stdc++.h>

using namespace std;

const int MAX = 101;

int M, N, K;


int myMap[MAX][MAX];
bool visited[MAX][MAX];
queue<pair<int, int>> Q;

int dx[4] = { -1,1,0,0 };
int dy[4] = { 0,0,-1,1 };

vector<int> V;

void BFS() {
	int area = 0;

	while (!Q.empty()) {
		pair<int, int> curr = Q.front(); Q.pop();
		area++;

		for (int dir = 0; dir < 4; dir++) {
			int nextX = curr.first + dx[dir];
			int nextY = curr.second+ dy[dir];

			if (nextX < 0 || nextX >= N || nextY < 0 || nextY >= M)continue;

			if (myMap[nextX][nextY] == 0 && !visited[nextX][nextY]) {
				visited[nextX][nextY] = true;
				Q.push({ nextX , nextY });
				
			}
		}
	}
	V.push_back(area);
}

int main(void) {
	ios::sync_with_stdio(0);
	cin.tie(0);

	cin >> M >> N >> K;

	for (int i = 0; i < K; i++) {
		int l_x, l_y, r_x, r_y;

		cin >> l_x >> l_y >> r_x >> r_y;

		for (int x = l_x; x < r_x; x++) {
			for (int y = l_y; y < r_y; y++) {
				myMap[x][y] = 1;
			}
		}
	}

	for (int i = 0; i < N; i++) {
		for (int j = 0; j < M; j++) {
			if (!visited[i][j] && myMap[i][j] == 0) {
				Q.push({ i, j });
				visited[i][j] = true;
				BFS();
			}
		}
	}
	sort(V.begin(), V.end());
	cout << V.size() << '\n';
	for (auto ele : V) {
		cout << ele << ' ';
	}

	return 0;
}
```



# 2667 단지번호붙이기

```c
#include<bits/stdc++.h>

using namespace std;

const int MAX = 25;

int N;

string myMap[MAX];
bool visited[MAX][MAX];

queue<pair<int, int>> Q;
int dy[4] = { -1, 1, 0, 0 };
int dx[4] = { 0, 0, -1, 1 };
vector<int> V;
void BFS() {
	int cnt = 0;
	while (!Q.empty()) {
		pair<int, int> curr = Q.front(); Q.pop();
		cnt++;
		for (int dir = 0; dir < 4; dir++) {
			int nextY = curr.first + dy[dir];
			int nextX = curr.second+ dx[dir];

			if (nextY < 0 || nextY >= N || nextX < 0 || nextX >= N)continue;

			if (myMap[nextY][nextX] == '1' && !visited[nextY][nextX]) {
				visited[nextY][nextX] = true;
				Q.push({ nextY,nextX });
			}
		}
	}
	V.push_back(cnt);
}

int main(void) {
	ios::sync_with_stdio(0);
	cin.tie(0);

	cin >> N;

	for (int i = 0; i < N; i++) {
		cin >> myMap[i];
	}

	for (int i = 0; i < N; i++) {
		for (int j = 0; j < N; j++) {
			if (myMap[i][j] == '1' && !visited[i][j]) {
				visited[i][j] = true;
				Q.push({ i,j });
				BFS();
			}
		}
	}

	cout << V.size() << '\n';
	sort(V.begin(), V.end());
	for (auto ele : V) {
		cout << ele << '\n';
	}
	

	return 0;
}
```



# 7562 나이트의 이동

```c
#include<bits/stdc++.h>

using namespace std;

const int MAX = 300;

int dy[8] = { -2, -1,  1,  2, 2, 1, -1, -2 };
int dx[8] = { -1, -2, -2, -1, 1, 2,  2, 1 };



int T;
int n;
pair<int, int> from_node, to_node;

void bfs() {
	queue<pair<int, int>> Q;

	Q.push(from_node);

	int res[MAX][MAX] = { 0, };
	while (!Q.empty()) {

		pair<int, int> curr = Q.front(); Q.pop();

		if (curr.first == to_node.first && curr.second == to_node.second) {
			cout << res[curr.first][curr.second]<< '\n';
			return;
		}

		for (int dir = 0; dir < 8; dir++) {
			int nextY = curr.first + dy[dir];
			int nextX = curr.second+ dx[dir];
			if (nextY < 0 || nextY >= n || nextX < 0 || nextX >= n)continue;
			if (res[nextY][nextX] > 0 || (nextY == from_node.first && nextX == from_node.second))continue;
			res[nextY][nextX] = res[curr.first][curr.second] + 1;
			Q.push({ nextY, nextX });
		}

	}
}


int main(void) {
	ios::sync_with_stdio(0);
	cin.tie(0);

	cin >> T;

	for (int t = 0; t < T; t++) {
		
		cin >> n;

		int a, b;
		cin >> a >> b;
		from_node = { a, b };
		cin >> a >> b;
		to_node = { a, b };

		bfs();

	}

	

	return 0;
}
```





# 10026 적록색약

```c
#include<bits/stdc++.h>

using namespace std;

const int MAX = 100;

int n;

string myMap[MAX];
queue<pair<int, int>> Q;

int dy[4] = { -1, 1, 0, 0 };
int dx[4] = { 0,0,-1,1 };
void bfs1() {
	bool visited[MAX][MAX] = { 0, };
	int section_num = 0;
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < n; j++) {
			if (!visited[i][j]) {
				char color = myMap[i][j];
				section_num++;
				visited[i][j] = true;
				Q.push({ i,j });
				
				while (!Q.empty()) {
					pair<int, int> curr = Q.front(); Q.pop();
					int y = curr.first;
					int x = curr.second;


					for (int dir = 0; dir < 4; dir++) {
						int ny = y + dy[dir];
						int nx = x + dx[dir];

						if (ny < 0 || ny >= n || nx < 0 || nx >= n)continue;

						if (myMap[ny][nx] == color && !visited[ny][nx]) {
							visited[ny][nx] = true;
							Q.push({ ny, nx });
						}
					}


				}



			}
		}
	}

	cout << section_num << ' ';

}

void bfs2() {
	bool visited[MAX][MAX] = { 0, };
	int section_num = 0;
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < n; j++) {
			if (!visited[i][j]) {
				char color = myMap[i][j];
				section_num++;
				visited[i][j] = true;
				Q.push({ i,j });

				while (!Q.empty()) {
					pair<int, int> curr = Q.front(); Q.pop();
					int y = curr.first;
					int x = curr.second;


					for (int dir = 0; dir < 4; dir++) {
						int ny = y + dy[dir];
						int nx = x + dx[dir];

						if (ny < 0 || ny >= n || nx < 0 || nx >= n)continue;

						if (color == 'R' || color == 'G') {
							if ((myMap[ny][nx] == 'R' || myMap[ny][nx] == 'G')&& !visited[ny][nx]) {
								visited[ny][nx] = true;
								Q.push({ ny, nx });
							}
						}
						else {
							if (myMap[ny][nx] == color && !visited[ny][nx]) {
								visited[ny][nx] = true;
								Q.push({ ny, nx });
							}
						}
					}
				}
			}
		}
	}

	cout << section_num;

}


int main(void) {
	ios::sync_with_stdio(0);
	cin.tie(0);

	cin >> n;

	for (int i = 0; i < n; i++) {
		cin >> myMap[i];
	}

	bfs1();

	bfs2();

	return 0;
}
```





# 2206 벽부수고 이동하기



**실패한 코드**

```c
#include<bits/stdc++.h>

using namespace std;

const int MAX = 1005;

int N, M;

string myMap[MAX];

struct Node {
	int y;
	int x;
	bool z;
};

queue<Node> Q;

int dy[4] = { -1, 1, 0, 0 };
int dx[4] = { 0,0,-1,1 };

int  res[MAX][MAX];

void printArr(int arr[][MAX]) {
	
	for (int i = 0; i < N; i++) {
		for (int j = 0; j < M; j++) {
			cout << arr[i][j] << ' ';
		}
		cout << '\n';
	}
	cout << '\n';
}

void bfs() {
	printArr(res);
	while (!Q.empty()) {
		int q_size = Q.size();
		while (q_size--) {
			Node curr = Q.front(); Q.pop();
			int cy = curr.y;
			int cx = curr.x;
			bool cz = curr.z;

			//cout << "(" << cy << ", " << cx << ")\n";

			if (cy == N-1 && cx == M-1) {
				cout << res[cy][cx];
				return;
			}
			for (int dir = 0; dir < 4; dir++) {
				int ny = cy + dy[dir];
				int nx = cx + dx[dir];

				if (ny < 0 || ny >= N || nx < 0 || nx >= N)continue;
				if (!cz && myMap[ny][nx] == '1')continue; //벽꺨수있는기회 없고 , 벽이면

				if (cz && myMap[ny][nx] == '1' && res[ny][nx] == 0) { //벽 깰수있고 벽이면
					//cout << "벽 꺨수있음 (" << ny << "," << nx << ")\n";
					res[ny][nx] = res[cy][cx] + 1;
					Q.push({ ny,nx, false });
				}
				else if (myMap[ny][nx] == '0' && res[ny][nx] == 0) { //0으로 진입가능하고 , 방문했던 적없으면

					//cout << "0으로 진입가능하고 , 방문했던 적없으면 (" << ny << "," << nx << "): " << myMap[ny][nx] << "\n";
					res[ny][nx] = res[cy][cx] + 1;
					Q.push({ ny, nx, cz });
				}
				else if (res[cy][cx] + 1 < res[ny][nx]) {
					//cout << "이미 방문했던 적있으나 더 작은 최소값이 될 수 있으면 (" << ny << "," << nx << ")\n";
					res[ny][nx] = res[cy][cx] + 1;
					Q.push({ ny, nx, cz });
				}
				else {
					//cout << "[" << ny << ", " << nx << "]X \n";
				}
			}
		}
		printArr(res);
	}
	cout << -1;
}

int main(void) {
	ios::sync_with_stdio(0);
	cin.tie(0);

	cin >> N >> M;

	for (int i = 0; i < N; i++)
		cin >> myMap[i];

	res[0][0] = 1;
	Q.push({ 0,0,true });

	bfs();
	

	return 0;
}

/*
6 4
0000
1110
1000
0000
0111
0000
*/
```



# 2468 안전 영역

런타임에러(Out of bound)

```
#include<bits/stdc++.h>

using namespace std;

queue<pair<int, int>> Q;

int dy[4] = { -1, 1, 0, 0 };
int dx[4] = { 0,0,-1,1 };
const int MAX = 101;
int myMap[MAX][MAX];

int curr[MAX][MAX];
bool visited[MAX][MAX];

int n;
int minH = 100, maxH = 1;
vector<int> V;

void bfs() {
	
	while (!Q.empty()) {

		int q_size = Q.size();
		while (q_size--) {

			pair<int, int> node = Q.front(); Q.pop();

			int y = node.first;
			int x = node.second;

			for (int dir = 0; dir < 4; dir++) {
				int ny = y + dy[dir];
				int nx = x + dx[dir];
				if (ny < 0 || ny >= n || nx < 0 || nx >= n)continue;
				if (curr[ny][nx] == 0 || visited[ny][nx])continue;
				visited[ny][nx] = true;
				Q.push({ ny, nx });
			}
		}
	}
}

int main(void) {
	ios::sync_with_stdio(0);
	cin.tie(0);

	cin >> n; 

	for (int i = 0; i < n; i++) {
		for (int j = 0; j < n; j++) {
			cin >> myMap[i][j];
			if (minH > myMap[i][j])minH = myMap[i][j];
			if (maxH < myMap[i][j])maxH = myMap[i][j];
		}
	}

	for (int water = minH; water < maxH; water++) {
		
		for (int i = 0; i < MAX; i++) {
			fill(curr[i], curr[i] + MAX, 0);
			fill(visited[i], visited[i] + MAX, 0);

		}
		
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < n; j++) {
				if (myMap[i][j] > water) {
					curr[i][j] = 1;
				}
			}
		}

		int tot = 0;
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < n; j++) {
				if (!visited[i][j] && curr[i][j] == 1) {
					visited[i][j] = true;
					Q.push({ i,j });
					bfs();
					tot++;
				}
			}
		}
		V.push_back(tot);
	}

	sort(V.begin(), V.end(), greater<int>());
	if (V.size() > 0) {
		cout << V[0];
	}
	else {
		cout << 0;
	}
	
	return 0;
}


```



# 2573 빙하

```c
#include<bits/stdc++.h>

using namespace std;

queue<pair<int, int>> Q;

int dy[4] = { -1, 1, 0, 0 };
int dx[4] = { 0,0,-1,1 };
const int MAX = 305;

int myMap[MAX][MAX];

int N, M;

int getVelocity(int y, int x) {
	int tot = 0;
	for (int dir = 0; dir < 4; dir++) {
		int ny = y + dy[dir];
		int nx = x + dx[dir];
		
		if (ny < 0 || ny >= N || nx < 0 || nx >= M)continue;
		if(myMap[ny][nx] == 0)tot++;
	}
	return tot;
}

void bfs(bool visited[][MAX]) {

	while (!Q.empty()) {

		int q_size = Q.size();

		while (q_size--) {

			pair<int, int> curr = Q.front(); Q.pop();
			int y = curr.first;
			int x = curr.second;

			for (int dir = 0; dir < 4; dir++) {
				int ny = y + dy[dir];
				int nx = x + dx[dir];

				if (ny < 0 || ny >= N || nx < 0 || nx >= M)continue;
				if (myMap[ny][nx] > 0 && !visited[ny][nx]) {
					visited[ny][nx] = true;
					Q.push({ ny, nx });
				}
			}

		}

	}

}

void printArr(int arr[][MAX]) {
	cout << '\n';
	for (int i = 0; i < N; i++) {
		for (int j = 0; j < M; j++) {
			cout << myMap[i][j] << ' ';
		}
		cout << '\n';
	}
	cout << '\n';
}

void solution() {
	int time = 0;

	//printArr(myMap);

	while (++time) {
		int temp[MAX][MAX] = { 0, };

		for (int i = 0; i < N; i++) {
			for (int j = 0; j < M; j++) {
				if (myMap[i][j] != 0) {
					int v = getVelocity(i, j);
					temp[i][j] = myMap[i][j] - v < 0 ? 0 : myMap[i][j] - v;
				}
			}
		}

		for (int i = 0; i < N; i++) {
			for (int j = 0; j < M; j++) {
				myMap[i][j] = temp[i][j];
			}
		}
		//printArr(myMap);

		bool visited[MAX][MAX] = { 0, };
		int area_cnt = 0;
		for (int i = 0; i < N; i++) {
			for (int j = 0; j < M; j++) {
				if (myMap[i][j] != 0 && !visited[i][j]) {
					//cout << "(" << i << "," << j << ")-> ";
					area_cnt++;
					visited[i][j] = true;
					Q.push({ i, j });
					bfs(visited);
				}
			}
		}
		//cout << '\n';
		if (area_cnt >= 2) {
			cout << time;
			return;
		}

		if (area_cnt == 0) {
			cout << 0;
			return;
		}
	}
}


int main(void) {
	ios::sync_with_stdio(0);
	cin.tie(0);

	cin >> N >> M;

	for (int i = 0; i < N; i++) {
		for (int j = 0; j < M; j++) {
			cin >> myMap[i][j];

		}
	}
	solution();
	return 0;
}


```



# 5427 불

```c
#include<bits/stdc++.h>

using namespace std;

queue<pair<int, int>> Q;

int dy[4] = { -1, 1, 0, 0 };
int dx[4] = { 0,0,-1,1 };
const int MAX = 1001;

char myMap[MAX][MAX];
int ans[MAX][MAX];
int w, h;


void printArr() {
	for (int i = 0; i < h; i++) {
		for (int j = 0; j < w; j++) {
			cout << myMap[i][j] << ' ';
		}
		cout << '\n';
	}
	cout << '\n';
}

void BFS(queue<pair<int, int>> h_q, queue<pair<int, int>> f_q) {

	for (int i = 0; i < MAX; i++)
		fill(ans[i], ans[i] + MAX, 0);
	//printArr();
	while (!h_q.empty()) {
		int f_q_size = f_q.size();
		while (f_q_size--) {
			pair<int, int> curr = f_q.front(); f_q.pop();
			int y = curr.first;
			int x = curr.second;
			for (int dir = 0; dir < 4; dir++) {
				int ny = y + dy[dir];
				int nx = x + dx[dir];
				if (myMap[ny][nx] == '.' || myMap[ny][nx] == '@') {
					myMap[ny][nx] = '*';
					f_q.push({ ny,nx });
				}
			}
		}

		int h_q_size = h_q.size();
		while (h_q_size--) {
			pair<int, int> curr = h_q.front(); h_q.pop();
			int y = curr.first;
			int x = curr.second;

			for (int dir = 0; dir < 4; dir++) {
				int ny = y + dy[dir];
				int nx = x + dx[dir];

				if (ny < 0 || ny >= h || nx < 0 || nx >= w) {
					cout << ans[y][x] + 1 << '\n';
					return;
				}
				if (myMap[ny][nx] == '.') {
					myMap[ny][nx] = '@';
					ans[ny][nx] = ans[y][x] + 1;
					h_q.push({ ny,nx });
				}
			}
		}

		
		//printArr();
	}

	cout << "IMPOSSIBLE\n";

}

int main(void) {
	ios::sync_with_stdio(0);
	cin.tie(0);
	int T;

	cin >> T;

	while (T--) {
		queue<pair<int, int>> h_q, f_q;

		cin >> w >> h;

		for (int i = 0; i < h; i++) {
			for (int j = 0; j < w; j++) {
				cin >> myMap[i][j];
				if (myMap[i][j] == '@') h_q.push({ i,j });
				if (myMap[i][j] == '*') f_q.push({ i,j });
			}
		}

		BFS(h_q, f_q);
	}


	
	return 0;
}


```





# 2146 다리만들기

보류하기... 유튜브에 문제풀이 있음



```c
#include<bits/stdc++.h>

using namespace std;

queue<pair<int, int>> Q;

int dy[4] = { -1, 1, 0, 0 };
int dx[4] = { 0,0,-1,1 };
const int MAX = 101;
int n;

int myMap[MAX][MAX];
int newMap[MAX][MAX];
bool visited[MAX][MAX];

int nthContinent;


pair<int, int> start;

void printArr(int arr[][MAX]) {
	cout << '\n';
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < n; j++) {
			cout << arr[i][j] << ' ';
		}
		cout << '\n';
	}
	cout << '\n';
}

void BFS() {
	queue<pair<int, int>> Q;
	Q.push(start);
	while (!Q.empty()) {
		pair<int, int> curr = Q.front(); Q.pop();

		int y = curr.first;
		int x = curr.second;
		newMap[y][x] = nthContinent;

		for (int dir = 0; dir < 4; dir++) {
			int ny = y + dy[dir];
			int nx = x + dx[dir];
			if (ny < 0 || ny >= n || nx < 0 || nx >= n)continue;
			if (myMap[ny][nx] == 1 && !visited[ny][nx]) {
				visited[ny][nx] = true;
				Q.push({ ny,nx });
			}
		}
		
	}
	
}



int main(void) {
	ios::sync_with_stdio(0);
	cin.tie(0);
	cin >> n;

	for (int i = 0; i < n; i++) {
		for (int j = 0; j < n; j++) {
			cin >> myMap[i][j];
		}
	}

	for (int i = 0; i < n; i++) {
		for (int j = 0; j < n; j++) {
			if (!visited[i][j] && myMap[i][j] == 1) {
				start = { i,j };
				visited[i][j] = true;				
				nthContinent++;
				BFS();
			}
		}
	}
	
	printArr(newMap);
	


	return 0;
}


```



# 5014 스타트링크

```c
#include<bits/stdc++.h>

using namespace std;


queue<int> Q;

int F, S, G, U, D;
bool visited[1000001];

int dx[2] = {};
int cnt;

void BFS() {

	while (!Q.empty()) {
		int q_size = Q.size();
		cnt++;

		//cout << "현재 depth: "<< cnt << " ) " ;
		for (int i = 0; i < q_size; i++) {
			int curr = Q.front(); Q.pop();
			
			//cout << curr << ' ';
			if (curr == G) {
				//cout << "\n\n";
				cout << cnt-1;
				return;
			}

			for (int dir = 0; dir < 2; dir++) {
				int next = curr + dx[dir];

				if (next < 1 || next > F)continue;
				if (visited[next])continue;
				visited[next] = true;
				Q.push(next);
			}
		}
		//cout << "\n";
		

	}
	cout << "use the stairs";
}

int main(void) {
	ios::sync_with_stdio(0);
	cin.tie(0);
	cin >> F >> S >> G >> U >> D;
	dx[0] = U;
	dx[1] = (-1)*D;
	visited[S] = true;
	Q.push(S);

	BFS();


	return 0;
}


```



# 6593 상범 빌딩

못품..

```c
#include<bits/stdc++.h>

using namespace std;

int L, R, C;
const int MAX = 30;
char myMap[MAX][MAX][MAX];

int res[MAX][MAX][MAX];
struct Node {
	int h;
	int y;
	int x;
};
int dh[6] = { -1, 1,  0, 0, 0, 0 };
int dy[6] = {  0, 0, -1, 1, 0, 0 };
int dx[6] = {  0, 0,  0, 0,-1, 1 };

Node startPos, endPos;

void printArr() {
	cout << '\n';
	for (int i = 0; i < L; i++) {
		for (int j = 0; j < R; j++) {
			for (int k = 0; k < C; k++) {
				cout << myMap[i][j][k] << ' ';
			}
			cout << '\n';
		}
		cout << '\n';
	}
	cout << '\n';
}

void bfs() {
	queue<Node> Q;
	Q.push(startPos);
	printArr();
	while (!Q.empty()) {
		int q_size = Q.size();

		//cout << "Q.size(): " << Q.size() << "\n";

		for (int i = 0; i < q_size; i++) {
			Node curr = Q.front(); Q.pop();

			int h = curr.h;
			int y = curr.y;
			int x = curr.x;

			//cout << "(" << h << "," << y << "," << x << ")-> ";

			//cout << "PUSH대상 노드: \n";

			for (int dir = 0; dir < 6; dir++) {
				int nh = h + dh[dir];
				int ny = y + dy[dir];
				int nx = x + dx[dir];

				//cout << "(" << dh[dir] << "," << dy[dir] << "," << dx[dir] << "): ";
				//cout << "(" << nh << "," << ny << "," << nx << ")-> \n";

				if (nh < 0 || nh >= L || ny < 0 || ny >= R || nx < 0 || nx >= C)continue;
				if (myMap[nh][ny][nx] == 'E') {
					cout << "Escaped in " << res[h][y][x] + 1 << " minute(s).\n";
					return;
				}

				if (myMap[nh][ny][nx] == '.') {
					myMap[nh][ny][nx] = 'S';
					res[nh][ny][nx] = res[h][y][x] + 1;
					Q.push({ nh, ny, nx });
				}
			}
		}
		printArr();
		//cout << '\n';
	}
	cout << "Trapped!\n";
}
int main(void) {
	ios::sync_with_stdio(0);
	cin.tie(0);
	 


	while (1) {

		cin >> L >> R >> C;
		if (L == 0 && R == 0 && C == 0)break;

		for (int i = 0; i < L; i++) {
			for (int j = 0; j < R; j++) {
				for (int k = 0; k < C; k++) {
					cin >> myMap[i][j][k];
					if (myMap[i][j][k] == 'S') {
						startPos = { i,j,k };
					}
					if (myMap[i][j][k] == 'E') {
						endPos = { i,j,k };
					}
				}
			}
		}
		
		bfs();
		
	}
	
	return 0;
}

/*

*/
```

