#include <vector>
#include <iostream>
using namespace std;

vector<vector<int>> board; // 전역 변수로 스도쿠 보드 선언
vector<pair<int, int>> emptyV;
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

bool duplicate(int row, int col, int num) {
    for (int i = 0; i < 9; i++) {
        if (board[row][i] == num || board[i][col] == num) return true;
    }

    int startRow = row - row % 3;
    int startCol = col - col % 3;

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[startRow + i][startCol + j] == num) return true;
      }
    }

    return false;
}

void printV() {
  for (int i = 0; i < 9; i++) {
    for (int j = 0; j < 9; j++) cout << board[i][j];
    cout << "\n";
  }
  cout << "\n";
}

bool solve_sudoku(int depth) {
    // depth위치의 공란에 중복없는 숫자값이 채워졌음을 보장받고 함수로 진입함
    cout << "depth: " << depth << "\n";
    printV();

    
    // 마지막 칸 유효한 숫자로 채워졌으므로 true 리턴
    if (depth + 1 == emptyV.size()) {
      cout << "--> 해답\n";
      return true;
    }
    

    // nextdepth위치
    int nextdepth = depth + 1;
    int next_row = emptyV[nextdepth].first;
    int next_col = emptyV[nextdepth].second;

    for (int num = 1; num <= 9; num++) {
        if (duplicate(next_row, next_col, num)) continue;
        
        board[next_row][next_col] = num;
        if (solve_sudoku(nextdepth)) return true;   // 백트래킹
        board[next_row][next_col] = 0;
    }
    cout << "depth: " << depth << "에서 못찾음\n\n";
    return false;
}

void init() {
  emptyV.clear();

  for (int y = 0; y < 9; y++) {
    for (int x = 0; x < 9; x++) {
      if (board[y][x] == 0) emptyV.push_back({y, x});
    }
  }
}

vector<vector<int>> solution(vector<vector<int>> input_board) {
  board = input_board;
  init();
  solve_sudoku(-1);
  // solve_sudoku(0); 잘못됨
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
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0}}
  ));
                
  /*
    출력값
    {{1, 2, 3, 4, 5, 6, 7, 8, 9}, 
    {4, 5, 6, 7, 8, 9, 1, 2, 3}, 
    {7, 8, 9, 1, 2, 3, 4, 5, 6}, 
    {2, 1, 4, 3, 6, 5, 8, 9, 7}, 
    {3, 6, 5, 8, 9, 7, 2, 1, 4}, 
    {8, 9, 7, 2, 1, 4, 3, 6, 5}, 
    {5, 3, 1, 6, 4, 2, 9, 7, 8}, 
    {6, 4, 2, 9, 7, 8, 5, 3, 1}, 
    {9, 7, 8, 5, 3, 1, 6, 4, 2}}
  */



  // print(solution({
  //   {5, 3, 0, 0, 7, 0, 0, 0, 0},
  //   {6, 0, 0, 1, 9, 5, 0, 0, 0},
  //   {0, 9, 8, 0, 0, 0, 0, 6, 0},
  //   {8, 0, 0, 0, 6, 0, 0, 0, 3},
  //   {4, 0, 0, 8, 0, 3, 0, 0, 1},
  //   {7, 0, 0, 0, 2, 0, 0, 0, 6},
  //   {0, 6, 0, 0, 0, 0, 2, 8, 0},
  //   {0, 0, 0, 4, 1, 9, 0, 0, 5},
  //   {0, 0, 0, 0, 8, 0, 0, 7, 9}}
  // ));                
  // cout << "\n";
  /*
    출력값
    {{5, 3, 4, 6, 7, 8, 9, 1, 2}, 
    {6, 7, 2, 1, 9, 5, 3, 4, 8}, 
    {1, 9, 8, 3, 4, 2, 5, 6, 7}, 
    {8, 5, 9, 7, 6, 1, 4, 2, 3}, 
    {4, 2, 6, 8, 5, 3, 7, 9, 1}, 
    {7, 1, 3, 9, 2, 4, 8, 5, 6}, 
    {9, 6, 1, 5, 3, 7, 2, 8, 4}, 
    {2, 8, 7, 4, 1, 9, 6, 3, 5}, 
    {3, 4, 5, 2, 8, 6, 1, 7, 9}} 
  */
  return 0;
}