// https://www.acmicpc.net/problem/16920

/*
확장 게임
시간 제한	메모리 제한	제출	정답	맞힌 사람	정답 비율
2 초	512 MB	9168	2184	1485	22.966%

문제

이 게임은 크기가 N×M인 격자판 위에서 진행되며, 
각 칸은 비어있거나 막혀있다. 

각 플레이어는 하나 이상의 성을 가지고 있고, 이 성도 격자판 위에 있다. 

입력
모든 플레이어는 적어도 하나의 성을 가지고 있으며, 게임에 참가하지 않는 플레이어의 성이 있는 경우는 없다.

출력
플레이어 1이 가진 성의 수, 2가 가진 성의 수, ..., P가 가진 성의 수를 공백으로 구분해 출력한다.

제한
1 ≤ N, M ≤ 1,000
1 ≤ P ≤ 9
1 ≤ Si ≤ 109

*/

#include<bits/stdc++.h>

using namespace std;

int dy[] = {-1, 1, 0, 0};
int dx[] = {0, 0, -1, 1};

int N, M, P;
int S[10];// i번 플레이어 마다 이동 가능한 거리 
char myMap[1000][1000];

queue<pair<int, int>> q[10];// p, y, x, s
int result[10];

void printV(){
    cout << "\n";
    for (int y = 0; y < N; y++) {
        for (int x = 0; x < M; x++) {
            cout << myMap[y][x] << " ";
        }
        cout << "\n";
    }
    cout << "\n";
}

int main() {
//첫째 줄에 격자판의 크기 N, M과 플레이어의 수 P가 주어진다.
    cin >> N >> M >> P;
// 둘째 줄에는 S1, S2, ...SP가 주어진다.
    for (int i = 0; i < P; i++) cin >> S[i + 1];

/*
'.'는 빈 칸, 
'#'는 벽, 
'1', '2', ..., '9'는 각 플레이어의 성
*/    
// 다음 N개의 줄에는 게임판의 상태가 주어진다. 

/*

1..1
#.##
....
...2

*/
    int emptySpace = 0;
    for (int y = 0; y < N; y++) {
        string tmp;
        cin >> tmp;
        for (int x = 0; x < M; x++) {
            myMap[y][x] = tmp[x];
            int p = myMap[y][x] - '0';

            if (tmp[x] == '.') emptySpace++;
            if (myMap[y][x] >= '1' && myMap[y][x] <= '9'){
                q[p].push({y, x});
                result[p]++;
            }
        }
    }

    cout << "emptySpace: " << emptySpace << "\n";

    
    while(emptySpace) {//모든 플레이어가 더 이상 확장을 할 수 없을 때 게임이 끝난다.
        for (int p = 1; p <= P; p++) {
            int maxSteps = S[p];
            while(maxSteps--) {            
                int size = q[p].size();
                if (size == 0) break;
                // cout << "p: " << p << "emptySpace: " << emptySpace << ", " << maxSteps << ", size: " << size << "\n";
                for (int size = 0; size < size; size++) {
                    auto curr = q[p].front(); q[p].pop();
                    int y = curr.first;
                    int x = curr.second;

                    for (int dir = 0; dir < 4; dir++){
                        int ny = y + dy[dir];
                        int nx = x + dx[dir];

                        if (ny < 0 || ny >= N || nx < 0 || nx >= M)continue;
                        if (myMap[ny][nx] != '.')continue;//벽이나 다른 플레이어의 성이 있는 곳으로는 이동할 수 없다. 

                        myMap[ny][nx] = (char)('0' + p);//플레이어 i는 자신의 성이 있는 곳에서 'Si칸 만큼 이동할 수 있는 모든 칸'에 성을 동시에 만든다. 
                        q[p].push({ny, nx});
                        result[p]++;
                        emptySpace--;
                        // cout << "myMap[" << ny << "][" << nx << "]: " << myMap[ny][nx] << "\n";
                    }
                }
                // printV();
            }
        }
        
    }

    //플레이어 1이 가진 성의 수, 2가 가진 성의 수, ..., P가 가진 성의 수를 공백으로 구분해 출력한다.
    for (int i = 1; i <= P; i++) cout << result[i] << " ";
    return 0;
}

/*
4 4 2
1 1
1...
....
....
...2



예제 입력 1 
3 3 2
1 1
1..
...
..2

예제 출력 1 
6 3

예제 입력 2 
3 3 2
1 1
1.1
...
..2
예제 출력 2 
7 2


예제 입력 3 
4 4 2
1 1
1...
....
....
...2
예제 출력 3 
10 6


예제 입력 4 
4 4 2
1 1
1..1
....
....
...2
예제 출력 4 
11 5


예제 입력 5 
4 4 2
2 1
1..1
....
....
...2
예제 출력 5 
14 2


예제 입력 6 
4 4 2
3 1
1..1
....
....
...2
예제 출력 6 
14 2


예제 입력 7 
4 4 2
1 1
1..1
#.##
....
...2
예제 출력 7 
7 6


예제 입력 8 
4 4 2
2 1
1..1
#.##
....
...2
예제 출력 8 
10 3


예제 입력 9 
3 4 4
1 1 1 1
....
#...
1234
예제 출력 9 
1 4 3 3
*/