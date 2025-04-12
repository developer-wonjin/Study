#include <bits/stdc++.h>

using namespace std;

int main() {
    vector<vector<int>> items = {
        {1, 6}, // A
        {2, 10},// B
        {3, 12} // C
    };
/*
     0  1  2  3  4  5

     0  0  0  0  0  0     0  0  0  0  0  0  0 
A    0  6  6  6  6  6     0  1  1  1  1  1  1
B    0  6 10 16 16 16     0  1  2  3  3  3  3
C    0  6 10 16 18 22 


*/
    int weight_limit = 5;
    int n = items.size();
    
    vector<vector<int>> dp(n + 1, vector<int>(weight_limit + 1, 0));

    for (int i = 1; i <= n; i++) {
        for (int w = 1; w <= weight_limit; w++) {
            int weight = items[i-1][0];
            int value  = items[i-1][1];

            if (weight <= w) {
                // 배낭의 한도w보다 물건i의 weight가 가벼운케이스 => 
                dp[i][w] = max(dp[i - 1][w], dp[i - 1][w - weight] + value);
            } else {
                // 배낭의 한도w보다 물건i가 무거운 케이스 => 물건i를 추가못함, i-1 케이스를 그대로 취함
                dp[i][w] = dp[i - 1][w];
            }
        }
    }

    cout << "\n";
    for (int i = 0; i <= n; i++) {
        for (int w = 0; w <= weight_limit; w++) {
            cout << setw(2) << dp[i][w] << " ";
        }
        cout << "\n";
    }
    cout << "\n";

    return 0;
}
