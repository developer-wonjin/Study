#include <vector>

using namespace std;

vector<vector<int>> board; // 전역 변수로 스도쿠 보드 선언

//❶ 특정 위치에 숫자를 놓을 수 있는지 확인
bool is_valid(int num, int row, int col) {
  for (int i = 0; i < 9; i++) {
    if (board[row][i] == num || board[i][col] == num) return false;
  }
  
  int startRow = row - row % 3, startCol = col - col % 3;
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[i + startRow][j + startCol] == num) return false;
    }
  }
  return true;
}

//❷ 아직 숫자가 입력되지 않은 위치를 확인 
pair<int, int> find_empty_position() {
  for (int row = 0; row < 9; row++) {
    for (int col = 0; col < 9; col++) {
      if (board[row][col] == 0) return {row, col};
    }
  }
  return {-1, -1};
}

/*
DFS함수 : 게임판을 채워나간다.
1.다 채웠으면 게임을 끝내라 (탈출조건)
   - 위치선정해보려했는데 못찾으면 다 채운거임

2.게임판을 채워나간다.
   - 위치선정하고
   - 그 위치가 스도쿠규칙에 맞는지 검사하고.
   - 번호를 채워라 
   - DFS : 탈출조건 살펴보고 게임판을 채워나가라
     if () return;
   - 번호를 지워라

*/
void solve_sudoku() { 
  pair<int, int> pos = find_empty_position();//위치선정

  if (pos.first == -1) return;  

  for (int num = 1; num <= 9; num++) {
    if (!is_valid(num, pos.first, pos.second)) continue;//스도쿠규칙에 맞는지 검사
    
    board[pos.first][pos.second] = num;//채워라
    solve_sudoku();
    if(find_empty_position().first == -1) return ;//순서도 유의
    board[pos.first][pos.second] = 0;
  }
}

vector<vector<int>> solution(vector<vector<int>> input_board) {
  //❹ 인자로 받은 보드를 전역 변수에 복사하고 스도쿠 진행
  board = input_board; 
  solve_sudoku();
  return board;
}




//아래 코드는 테스트 코드 입니다.
#include <iterator>
#include <iostream>

using namespace std;

void print(vector<vector<int>> vec)
{
    
  for(int i = 0; i < vec.size(); i++ ){
    copy(vec[i].begin(), vec[i].end(), std::ostream_iterator<int>(cout, " "));
    cout << endl;
  }
    
}

int main()
{
  print(solution({
                    {5, 3, 0, 0, 7, 0, 0, 0, 0},
                    {6, 0, 0, 1, 9, 5, 0, 0, 0},
                    {0, 9, 8, 0, 0, 0, 0, 6, 0},
                    {8, 0, 0, 0, 6, 0, 0, 0, 3},
                    {4, 0, 0, 8, 0, 3, 0, 0, 1},
                    {7, 0, 0, 0, 2, 0, 0, 0, 6},
                    {0, 6, 0, 0, 0, 0, 2, 8, 0},
                    {0, 0, 0, 4, 1, 9, 0, 0, 5},
                    {0, 0, 0, 0, 8, 0, 0, 7, 9}
                }));

  /*
    출력값
    5 3 4 6 7 8 9 1 2 
    6 7 2 1 9 5 3 4 8 
    1 9 8 3 4 2 5 6 7 
    8 5 9 7 6 1 4 2 3 
    4 2 6 8 5 3 7 9 1 
    7 1 3 9 2 4 8 5 6 
    9 6 1 5 3 7 2 8 4 
    2 8 7 4 1 9 6 3 5 
    3 4 5 2 8 6 1 7 9 
  */

  cout << "\n";

  print(solution({
                    {0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0}
                }));
                
  /*
    출력값
        1 2 3 4 5 6 7 8 9 
        4 5 6 7 8 9 1 2 3 
        7 8 9 1 2 3 4 5 6 
        2 1 4 3 6 5 8 9 7 
        3 6 5 8 9 7 2 1 4 
        8 9 7 2 1 4 3 6 5 
        5 3 1 6 4 2 9 7 8 
        6 4 2 9 7 8 5 3 1 
        9 7 8 5 3 1 6 4 2 
  */
  return 0;
}