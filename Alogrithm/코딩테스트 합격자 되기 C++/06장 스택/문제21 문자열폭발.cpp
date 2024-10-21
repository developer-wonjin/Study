//https://www.acmicpc.net/problem/9935

#include <bits/stdc++.h>

using namespace std;

string str;
string bomb;

int main(){
    ios::sync_with_stdio(0); cin.tie(0);

    cin >> str >> bomb;

    string result = "";
    int bomb_len = bomb.size();

    int cnt = 0;
    for (char c : str) {
        cnt ++;
        result.push_back(c);  // 결과 문자열에 한 글자씩 추가

        // 현재 결과 문자열에서 폭발 문자열의 마지막 부분과 일치하는지 확인
        if (result.size() >= bomb_len && result.substr(result.size() - bomb_len, bomb_len) == bomb) {
            cnt++;
            result.erase(result.size() - bomb_len, bomb_len);  // 폭발 문자열 제거
        }
    }

    // 결과가 비어 있으면 "FRULA" 출력
    cout << (result.empty() ? "FRULA" : result) << '\n';
    cout << cnt << "\n";

    return 0;
}