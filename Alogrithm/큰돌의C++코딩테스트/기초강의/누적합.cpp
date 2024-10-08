#include<bits/stdc++.h>

using namespace std;


/*       0   1   2   3   4
arr          1  10  11 100  
psum     0   1  11  22 122
*/

// 입력데이터가 4라면 +1한 5를 만든다.
// 인덱스 1부터 
// (프로그래머스) 실패율 이라는 문제 풀어보기~
const int nmax = 4 + 1; 

int nums[5],prefixSum[5];
int myStart, myEnd, n;
int m;

int main(){
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    cout.tie(NULL);

    cin >> n >> m;

    for (int i = 1; i <= n; i++){
        cin >> nums[i];
        prefixSum[i] = prefixSum[i-1] + nums[i];
    }


    for (int i = 0; i < m; i++){
        cin >> myStart >> myEnd;

        //구간합 [s, e] 을 구해라
        cout << prefixSum[myEnd] - prefixSum[myStart - 1] << "\n";
    }


}