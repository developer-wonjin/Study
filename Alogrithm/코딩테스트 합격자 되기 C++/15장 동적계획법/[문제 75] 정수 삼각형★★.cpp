#include <vector>
#include <iostream>
#include <iomanip> // setw, setfill 사용을 위한 헤더

using namespace std;

void printV(vector<vector<int>>& dp, int n) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            // 두 자리로 맞추어 출력 (빈 자리엔 공백을 채움)
            cout << setw(2) << setfill(' ') << dp[i][j] << " ";
        }
        cout << "\n";
    }
    cout << "\n";
    cout << "\n";
}

int solution(vector<vector<int>> triangle) {
    int n = triangle.size();
    vector<vector<int>> dp(n, vector<int>(n, 0)); // ➊ dp 테이블 초기화
    
    // ➋ dp 테이블의 맨 아래쪽 라인 초기화
    for (int i = 0; i < n; i++) {
        dp[n - 1][i] = triangle[n - 1][i];
    }
    
    // ➌ 아래쪽 라인부터 올라가면서 dp 테이블 채우기
    for (int i = n - 2; i >= 0; i--) {
        for (int j = 0; j <= i; j++) {
            dp[i][j] = max(dp[i + 1][j], dp[i + 1][j + 1]) + triangle[i][j];
            printV(dp, n);
        }
    }
    
    return dp[0][0]; // 꼭대기에서의 최댓값 반환
}

// 테스트 코드
int main()
{
  cout << solution({{7}, {3, 8}, {8, 1, 0}, {2, 7, 4, 4}, {4, 5, 2, 6, 5}}) << endl; // 출력값: 30
  return 0;
}
