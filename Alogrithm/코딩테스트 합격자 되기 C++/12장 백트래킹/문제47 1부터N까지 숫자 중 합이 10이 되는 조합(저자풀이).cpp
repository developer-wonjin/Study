#include <vector>
#include <iterator>
#include <iostream>

using namespace std;

vector<vector<int>> results;
vector<int> selected_nums;

void printV(vector<int>& v) {
    for (const auto& ele : v) {
        cout << ele << " ";
    }
    cout << "\n";
}

void backtrack(int N, int sum, int start) {
    cout << "start: " << start << " | " << "sum: " << sum << " |";
    printV(selected_nums);

  //❶ 합이 10인경우, 조합을 결과에 추가하고 종료
  if (sum == 10) {
    results.push_back(selected_nums);
    return;
  }
  for (int i = start + 1; i < N; ++i) {
    //❷ 합이 10보다 적은 경우, 가능한 조합을 계속 확인
    if (sum + i <= 10) {
      selected_nums.push_back(i);
      backtrack(N, sum + i, i);
      selected_nums.pop_back();
    }
  }
}

vector<vector<int>> solution(int N) {
  //❸ 숫자 1부터 백트래킹 시작
  backtrack(N, 0, 0);
  return results;
}

void init()
{
  results.clear();
  selected_nums.clear();    
}

void print(vector<vector<int>> vec)
{
    cout << "\n 정답: ";
  for(int i = 0; i < vec.size(); i++ ){
    copy(vec[i].begin(), vec[i].end(), std::ostream_iterator<int>(cout, " "));
    cout << endl;
  }
    
}

int main()
{
  print(solution(5));
//   init();
  /*
    출력값
    1 2 3 4 
    1 4 5 
    2 3 5 
  */
//   print(solution(2));
//   init();
  /*
    출력값(없음)
  */  
//   print(solution(7));
  /*
    출력값
    1 2 3 4 
    1 2 7 
    1 3 6 
    1 4 5 
    2 3 5 
    3 7 
    4 6 
  */
  return 0;
}