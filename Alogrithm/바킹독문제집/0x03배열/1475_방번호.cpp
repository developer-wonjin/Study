//https://www.acmicpc.net/problem/1475
#include<bits/stdc++.h>

using namespace std;

int arr[10];
int N;

int main(){
    ios::sync_with_stdio(0); cin.tie(0);

    cin >> N;

    string nStr = to_string(N);

    for (auto c : nStr) {
        arr[c - '0']++;
    }

    // ★★★★자리수 추출★★★★★
    while(N){
        arr[N % 10]++;
        N /= 10;
    }


    int tot69 = arr[6] + arr[9]; 

    int maxValue = -987654321;
    for (int i = 0; i < 10; i++) {
        if (i == 6 || i == 9)continue;
        maxValue = max(maxValue, arr[i]);
    }
    maxValue = max(maxValue, (tot69 + 1)/2);

    cout << maxValue;
    // 0 1 2 3 4 5 6 7 8 9
    //             1       => 1
    //                   1 => 1
    //             1     1 => 1
    //             2       => 1
    //                   2 => 1
    //             2     1 => 2
    //             2     2 => 2


    /*
     세트에는 0번부터 9번까지 숫자가 하나씩 들어있다. 
     필요한 세트의 개수의 최솟값을 출력하시오. 
     (6은 9를 뒤집어서 이용할 수 있고, 9는 6을 뒤집어서 이용할 수 있다.)
    
    */

    return 0;
}