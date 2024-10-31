//https://www.acmicpc.net/source/share/1a1898996c8542889b32b4c1b2498dd0
#include<bits/stdc++.h>

using namespace std;

/*
문제
알파벳 소문자로만 이루어진 단어 S가 주어진다. 각 알파벳이 단어에 몇 개가 포함되어 있는지 구하는 프로그램을 작성하시오.

입력
첫째 줄에 단어 S가 주어진다. 단어의 길이는 100을 넘지 않으며, 알파벳 소문자로만 이루어져 있다.
baekjoon

출력
단어에 포함되어 있는 a의 개수, b의 개수, …, z의 개수를 공백으로 구분해서 출력한다.
1 1 0 0 1 0 0 0 0 1 1 0 0 1 2 0 0 0 0 0 0 0 0 0 0 0
*/

string s;
int n = 'z' - 'a' + 1;
vector<int> cnt(n, 0);
int main () {
    ios::sync_with_stdio(0); cin.tie(0);
    
    cin >> s;

    for (auto& ch : s) {
        cnt[ch - 'a']++;
    }

    for (auto& ele : cnt) cout << ele << " ";

    return 0;
}