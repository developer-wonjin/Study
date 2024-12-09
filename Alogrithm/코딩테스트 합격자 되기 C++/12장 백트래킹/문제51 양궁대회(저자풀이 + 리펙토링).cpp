// https://school.programmers.co.kr/learn/courses/30/lessons/92342

#include <vector>
#include <iostream>
using namespace std;
const int ZERO = 10;
vector<int> answer; // 라이언이 가장 큰 점수 차이로 승리할 수 있는 경우의 화살 배치를 저장
vector<int> ryan(11, 0); // 라이언의 점수를 기록하는 배열
int maxScore = -1; // 현재까지 발견된 최대 점수 차이 (초기값: -1)

//❶ 어피치와 라이언의 점수 차이를 계산
int calcScoreDiff(const vector<int> &apeach) {
  int scoreApeach = 0; // 어피치의 총 점수
  int scoreLion = 0; // 라이언의 총 점수

  for (int i = 0; i < 11; ++i) { // 10점 과녁부터 0점 과녁까지 점수를 계산
    if (apeach[i] == 0 && ryan[i] == 0) continue; // 두 사람이 모두 화살을 쏘지 않은 과녁은 무시
    if (apeach[i] >= ryan[i]) scoreApeach += 10 - i; // 어피치가 점수를 얻은 경우
    else scoreLion += 10 - i; // 라이언이 점수를 얻은 경우
  }

  return scoreLion - scoreApeach; // 점수 차이 반환
}

//❷ DFS를 통해 가능한 모든 경우를 탐색
void dfs(const vector<int> &apeach, int score, int arrow) {
  // 현재 점수와 남은 화살을 출력 (디버깅용)
  cout << "score: " << score << ", arrow: " << arrow << "\n";
  for (auto& ele : ryan) cout << ele << " ";
  cout << "\n";
  for (auto& ele : apeach) cout << ele << " ";
  cout << "\n";
  

  cout << "\n\n";

  if (score == -1 || arrow == 0) { // 모든 점수를 탐색했거나 화살이 모두 소진된 경우
    cout << "탐색완료 or 화살모두소진됨\n";
    ryan[ZERO] = arrow; // 남은 화살을 0점 과녁에 배치
    int scoreDiff = calcScoreDiff(apeach); // 점수 차이를 계산
    //❷ 현재 구한 점수 차이가 기존 최대 점수 차이보다 크고, 라이언의 점수가 높은 경우
    if (scoreDiff > 0 && maxScore < scoreDiff) {
      cout << "update발생~!!!\n";
      maxScore = scoreDiff; // 최대 점수 차이 갱신
      answer = ryan; // 최대 점수 차이를 낸 화살 배치 저장
    }
    ryan[ZERO] = 0; // 0점 과녁 화살 수 초기화
    return; // 탐색 종료
  }

  //❸ 어피치가 쏜 화살 수보다 더 많은 화살을 쏠 수 있는 경우
  if (arrow > apeach[score]) {
    cout << "어피치가 쏜 화살 수보다 더 많은 화살을 쏠 수 있는 경우\n";
    ryan[score] = apeach[score] + 1; // 어피치를 이길 만큼 화살 배치
    dfs(apeach, score - 1, arrow - apeach[score] - 1); // 남은 화살로 다음 점수 탐색
    ryan[score] = 0; // 탐색 후 초기화
  }

  //❹ 어피치를 포기하고 화살을 사용하지 않는 경우
  cout << "어피치를 포기하고 화살을 사용하지 않는 경우\n";
  dfs(apeach, score - 1, arrow); // 현재 점수에서 화살 사용 없이 다음 점수 탐색
}

//❺ 라이언의 승리 가능성을 탐색하고 최적의 화살 배치를 반환
vector<int> solution(int n, vector<int> info) {
  dfs(info, 10, n); // DFS를 시작 (10점 과녁부터 탐색)

  //❻ 라이언이 이길 수 없는 경우
  if (maxScore == -1) answer.push_back(-1); // 불가능한 경우 -1 반환

  return answer; // 최적의 화살 배치 반환
}

// 테스트 코드
#include <iostream>
#include <iterator>
using namespace std;

// 전역 변수 초기화 함수
void init() {
  answer.clear(); // 결과 초기화
  maxScore = -1; // 최대 점수 차이 초기화

  for (int i = 0; i < ryan.size(); i++)
    ryan[i] = 0; // 라이언 점수 초기화
}

// 벡터 출력 함수
void print(vector<int> vec) {
  copy(vec.begin(), vec.end(), ostream_iterator<int>(cout, " ")); // 벡터 요소를 출력
  cout << endl;
}

int main() {
  print(solution(5, {2, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0})); // 출력값: 0 2 2 0 1 0 0 0 0 0 0
  // init();
  // print(solution(1, {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})); // 출력값: -1
  // init();
  // print(solution(9, {0, 0, 1, 2, 0, 1, 1, 1, 1, 1, 1})); // 출력값: 1 1 2 0 1 2 2 0 0 0 0
  return 0;
}
