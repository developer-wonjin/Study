//https://www.acmicpc.net/problem/10808
#include<bits/stdc++.h>
using namespace std;

string s;

// 이중반복으로 인한 문자열을 여러번 탐색하는 비효율 발생
void solution1() {

    for(char alp = 'a'; alp <= 'z'; alp++){
        // 각 알파벳별로
        int cnt = 0;
        for (auto c : s){
            // 입력문자열의 문자를 살펴본다
            if (c == alp) cnt++;
        }
        cout << cnt << " ";
    }
    cout << "\n";
}

// 배열 자료구조를 이용하면 쓸데없는 반복을 줄일 수 있다
void solution2(){
    int NMAX = 'z' - 'a' + 1;
    int arr[NMAX];

    fill(arr, arr+NMAX, 0);

    for (auto c : s) {
        arr[c-'a']++;
    }

    for (auto ele : arr){
        cout << ele << " ";
    }
    cout << "\n";
}

int main(){

    cin >> s;
    solution1();
    solution2();

    return 0;
}