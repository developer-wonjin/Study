//https://www.acmicpc.net/problem/11328

#include<bits/stdc++.h>

using namespace std;

int N;
string str1, str2;
const int LEN = 'z'-'a'+1;
void printCheck(int check [], int size){
    for (int i = 0; i < size; i++) cout << check[i] << " ";
    cout << "\n";
}

int main(){

    ios::sync_with_stdio(0); cin.tie(0);

    /*
    입력의 첫 번째 줄은 테스트 케이스의 수 0 < N < 1001 이다.

    각각의 테스트 케이스는 하나의 줄에 영어 소문자들로만 이루어진 두 개의 문자열이 한 개의 공백으로 구분되어 주어진다.
    각각의 문자열의 길이는 최대 1000 이다.
    */

    cin >> N;
    for(int i = 0; i < N; i++){
        cin >> str1 >> str2;

        int check[LEN] = {};

        for (auto c : str1){
            check[c - 'a']++;
        }

        for (auto c : str2){
            check[c - 'a']--;
        }

        int tot = 0;
        for (int i = 0; i < LEN; i++) {
            tot += abs(check[i]);
        }

        if (tot) cout << "Impossible\n";
        else cout << "Possible\n";

    }

    return 0;
}