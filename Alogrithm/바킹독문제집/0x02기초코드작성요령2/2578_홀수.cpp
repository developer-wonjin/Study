/*
홀수가 존재하지 않는 경우에는 첫째 줄에 -1을 출력한다. 
홀수가 존재하는 경우 첫째 줄에 홀수들의 합을 출력

둘째 줄에 홀수들 중 최솟값을 출력한다.
*/

#include<iostream>
#include<vector>
#include<algorithm>

using namespace std;

void solution(){

    vector<int> v;

    int oddExist = 0;
    int sum = 0;
    int minOdd = 987654321;
    int input;
    for (int i = 0; i < 7; i++) {
        cin >> input;
        if (input & 1){
            oddExist++;
            sum += input;
            minOdd = min(minOdd, input);
        } 
    }

    if (oddExist) {
        cout << sum << "\n";
        cout << minOdd;
    }else {
        cout << "-1";
    }


}

int main(){
    ios::sync_with_stdio(0); cin.tie(0);
    solution();
    return 0;
}