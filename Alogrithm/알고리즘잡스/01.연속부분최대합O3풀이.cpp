/*
연속된 부분을 선택하여, 그 합이 최대가 되게 하라
8
1 2 -4 5 3 -2 9 10  (1 <= n <= 100)
25

8
-1 -2 -3 -4 -5 -6 -7 -8
-1 (결과)

5
1 2 3 4 5
15 (결과)
*/

#include<bits/stdc++.h>

using namespace std;

const int MAX = 10;

int n;
int arr[MAX];

int main() {

    ios::sync_with_stdio(0); cin.tie(0);

    cin >> n;
    for (int i = 0; i < n; i++) {
        cin >> arr[i];
    }

    int myMax = -987654321;
    for (int start = 0; start < n; start++) {
        for (int end = start; end < n; end++) {
            int mySum = 0;
            for (int k = start; k <= end; k++) {
                mySum += arr[k];
            }
            myMax = max(myMax, mySum);
        }
    }

    cout << myMax;
    return 0;
}