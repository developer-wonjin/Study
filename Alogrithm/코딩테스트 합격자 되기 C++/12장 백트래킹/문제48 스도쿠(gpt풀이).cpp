#include <vector>
#include <iostream>
#include <iterator>

using namespace std;

vector<vector<int>> board;
vector<pair<int, int>> emptyV;
bool rowCheck[9][10], colCheck[9][10], boxCheck[9][10];

int get_box_idx(int row, int col) {
    return (row / 3) * 3 + (col / 3);
}

bool solve_sudoku(int idx) {
    if (idx == emptyV.size()) return true;  // 모든 빈 칸을 채우면 종료

    int row = emptyV[idx].first;
    int col = emptyV[idx].second;
    int boxIdx = get_box_idx(row, col);

    for (int num = 1; num <= 9; num++) {
        if (!rowCheck[row][num] && !colCheck[col][num] && !boxCheck[boxIdx][num]) {
            board[row][col] = num;
            rowCheck[row][num] = colCheck[col][num] = boxCheck[boxIdx][num] = true;

            if (solve_sudoku(idx + 1)) return true;

            board[row][col] = 0;
            rowCheck[row][num] = colCheck[col][num] = boxCheck[boxIdx][num] = false;
        }
    }

    return false;
}

void init() {
    emptyV.clear();  // 빈 칸 정보 초기화

    for (int y = 0; y < 9; y++) {
        for (int x = 0; x < 9; x++) {
            if (board[y][x] == 0) {
                emptyV.push_back({y, x});
            } else {
                int num = board[y][x];
                int boxIdx = get_box_idx(y, x);
                rowCheck[y][num] = colCheck[x][num] = boxCheck[boxIdx][num] = true;
            }
        }
    }
}

vector<vector<int>> solution(vector<vector<int>> input_board) {
    board = input_board;
    init();
    solve_sudoku(0);
    return board;
}

void print(vector<vector<int>> vec) {
    for (int i = 0; i < vec.size(); i++) {
        copy(vec[i].begin(), vec[i].end(), ostream_iterator<int>(cout, " "));
        cout << endl;
    }
}

int main() {
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
    return 0;
}
