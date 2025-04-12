#include <string>
#include <vector>
#include <algorithm>
#include <iostream>
using namespace std;

// DP 테이블 출력 함수
void printDP(const vector<vector<int>>& dp, int m, int n, string& str1, string& str2) {

  cout << "str1: " << str1 << "\n";
  cout << "str2: " << str2 << "\n";

  for (int i = 1; i <= m; i++) {
    for (int j = 1; j <= n; j++) {
      cout << dp[i][j] << " ";
    }
    cout << "\n";
  }
  cout << "\n";
}

// 두 문자열의 LCS 길이를 계산하는 함수
int solution(string str1, string str2) {
  int m = str1.length();
  int n = str2.length();

  // DP 테이블 초기화
  vector<vector<int>> dp(m + 1, vector<int>(n + 1, 0));

  // LCS 길이 계산
  for (int i = 1; i <= m; ++i) {
    for (int j = 1; j <= n; ++j) {
      if (str1[i - 1] == str2[j - 1]) {
        dp[i][j] = dp[i - 1][j - 1] + 1;
      } else {
        dp[i][j] = max(dp[i - 1][j], dp[i][j - 1]);
      }

      printDP(dp, m, n, str1, str2); cout << "\n";
    }
  }



  return dp[m][n];
}

// 테스트 코드
int main() {
  cout << solution("ABCBDAB", "BDCAB") << endl; // 출력값: 4
  // cout << solution("AGGTAB", "GXTXAYB") << endl; // 출력값: 4
  return 0;
}
