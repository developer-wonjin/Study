# DFS

<hr>

**스택**

- 일들사이에 **선행관계**가 존재할 때.
- 발자취를 남길 때



## 1. 정의  

콜스택을 사용하는 DFS

- 나를 먼저  방문하고 그 다음 인접한 노드를 차례로 방문한다.

 ```c
DFS(v, visited):
1. v를 방문했다고 처리한다.
2. v와 인접한 모든 w에 대하여 다음을 반복
3. 만약 w를 아직 방문하지 않았다면,
4.    DFS(w, visited)
5. 방문순서 반환
 ```

## 2. 구현

```c
// 첫 째줄 (정점의 갯수, 간선의 갯수)
// 그 이후 (정점번호, 연결된 정점)
/*

1-------2---------6
 \     / \       /
  \   /   4 --- 5
   \ /   / \ 
    3 - 7 - 8 - 9 

9 12
1 2
1 3
2 3
2 4
2 6
3 7
4 5
4 7
4 8
5 6
7 8
8 9
*/
#include <iostream>
#include <vector>
using namespace std;
const int MAX = 100;

int n, m; //정점, 간선
vector<int> myGraph[MAX]; 
bool visited[MAX];

void DFS(int x) {
	visited[x] = true;
	cout << x << " ";


	for (int i = 0; i < myGraph[x].size(); i++) {
		int y = myGraph[x][i];
		//if (y != 0) { } 인접행렬이 아닌 vector로 구현한 연결리스트이기 때문에 y가 0일리가 없다. (반면에, 인접행렬은 연결되지 않은 노드들간의 정보 0도 담고있다)
		if (!visited[y]) {
			DFS(y);
		}
	}
}

int main() {
	ios::sync_with_stdio(0);
	cin.tie(0);


	cin >> n >> m;
	
	for (int i = 0; i < m; i++) {
		int a, b;
		cin >> a >> b;
		myGraph[a].push_back(b);
		myGraph[b].push_back(a);
	}

	DFS(1);

	return 0;
}
```



## 3. 시간복잡도 O(V+E)     ---- v:정점 , E: 간선

차수의 합 = |V| * 2

O(V + 2*E)  따라서 O(V+E)

# 코딩 팁

- 전역변수를 적극 활용하여 함수의 파라미터로 전달할 수고를 줄여준다.

```c
#include <iostream>
#include <vector>
using namespace std;
const int MAX = 100;

int n, m; //정점, 간선
vector<int> myGraph[MAX];
bool visited[MAX];
```





