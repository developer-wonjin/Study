#include <vector>
#include <iterator>
#include <iostream>

using namespace std;

// 2차원 벡터를 출력하는 함수
void print(const vector<vector<int>>& vec) {
    for (const auto& row : vec) {
        copy(row.begin(), row.end(), ostream_iterator<int>(cout, " "));
        cout << endl;
    }
    cout << "\n";
}

// 달팽이 배열을 생성하는 함수
vector<vector<int>> solution(int n) {
    // N*N 크기의 2차원 벡터 초기화
    vector<vector<int>> snail_array(n, vector<int>(n, 0));
    int num = 1;  // 채울 숫자

    // 방향: 오른쪽, 아래, 왼쪽, 위쪽 (시계 방향 순서)
    int dx[] = {1, 0, -1, 0}; // x 변화량
    int dy[] = {0, 1, 0, -1}; // y 변화량
    int dir = 0;  // 현재 방향 인덱스

    // 현재 위치 초기화
    int y = 0, x = 0;

    // 배열을 채울 동안 반복
    while (num <= n * n) {
        snail_array[y][x] = num++;  // 현재 위치에 숫자 채우기
        print(snail_array);        // 중간 결과 출력

        // 다음 위치 계산
        int ny = y + dy[dir];
        int nx = x + dx[dir];

        // 다음 위치가 범위를 벗어나거나 이미 채워진 경우 방향 전환
        if (ny < 0 || ny >= n || nx < 0 || nx >= n || snail_array[ny][nx] != 0) {
            dir = (dir + 1) % 4;  // 방향 전환
            ny = y + dy[dir];
            nx = x + dx[dir];
        }

        // 위치 갱신
        y = ny;
        x = nx;
    }

    return snail_array;
}

int main() {
    print(solution(3));
    /*
    출력값 :
    1 2 3 
    8 9 4 
    7 6 5
    */
                    
    print(solution(4));
    /*
    출력값: 
    1 2 3 4 
    12 13 14 5 
    11 16 15 6 
    10 9 8 7
    */
    return 0;
}
