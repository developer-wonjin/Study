#include <vector>
#include <iterator>
#include <iostream>
#include <iomanip>

using namespace std;

void print(vector<vector<int>> vec)
{
  for (int i = 0; i < vec.size(); i++) {
    for (int j = 0; j < vec[i].size(); j++) {
      cout << setw(2) << setfill('0') << vec[i][j] << " ";
    }
    cout << endl;
  }
  cout << endl;
}

vector<vector<int>> solution(int n) {

  // ❶ N*N 2차원 벡터를 선언하고 초깃값을 0으로 함
  vector<vector<int>> snail_array(n, vector<int>(n, 0));
  int num = 1;
  // 행과 열의 시작과 끝 인덱스를 설정
  int start_row = 0, end_row = n - 1;
  int start_col = 0, end_col = n - 1;

  // ❷ 제일 외각부터 달팽이 수열 규칙대로 채움
  while (start_row <= end_row && start_col <= end_col) {
    // 가장 왼쪽 윗부분에서 가장 아래 바로 직전까지 채우기
    for (int i = start_col; i <= end_col; ++i) {
      snail_array[start_row][i] = num++;
    }
    ++start_row;
    print(snail_array);

    // 가장 왼쪽 아래부분에서 가장 오른쪽 바로 직전까지 채우기
    for (int i = start_row; i <= end_row; ++i) {
      snail_array[i][end_col] = num++;
    }
    --end_col;
    print(snail_array);

    // 가장 오른쪽 아래부분에서 가장 위 바로 직전까지 채우기
    if (start_row <= end_row) {
      for (int i = end_col; i >= start_col; --i) {
        snail_array[end_row][i] = num++;
      }
      --end_row;
      print(snail_array);
    }

    // 가장 윗부분에서 가장 왼쪽 바로 직전까지 채우기
    if (start_col <= end_col) {
      for (int i = end_row; i >= start_row; --i) {
        snail_array[i][start_col] = num++;
      }
      ++start_col;
      print(snail_array);
    }
  }

  return snail_array;
}

// 아래 코드는 테스트 코드입니다.

int main()
{
  solution(5);
  /*
  출력값:
  _01 _02 _03 _04 _05 
  _16 _17 _18 _19 _06 
  _15 _24 _25 _20 _07 
  _14 _23 _22 _21 _08 
  _13 _12 _11 _10 _09 
  */

  return 0;
}
