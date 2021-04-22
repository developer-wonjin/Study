# DFS

<hr>

**스택**

- 일들사이에 **선행관계**가 존재할 때.
- 발자취를 남길 때



**콜스택을 사용하는 DFS**

- 나를 먼저 방문하고 그 다음 인접한 노드를 차례로 방문한다.

 ```c
DFS(v, visited):
1. v를 방문했다고 처리한다.
2. v와 인접한 모든 w에 대하여 다음을 반복
3. 만약 w를 아직 방문하지 않았다면,
4.    DFS(w, visited)
5. 방문순서 반환
 ```

```c
void DFS(Graph graph, int x, bool visited[]){
    visited[x] = true;
    for(int i=0; i<graph[x].size(); i++){
        int y = graph[x][i];
        if(visited[y] == false){
            DFS(graph, y, visited);
        }
    }
}
```





