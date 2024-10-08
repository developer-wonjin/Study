//해설
//https://www.acmicpc.net/source/share/5cbef80aaad4484a8c3ea73bebf2c0ab
//https://www.acmicpc.net/source/share/6b0acb8d4af043f88800c74b72d77610
//https://www.acmicpc.net/source/share/2da2c198ee3744e2babea1986b2fffd6

#include<bits/stdc++.h>

using namespace std;


int input;
int check[101];
void solution(){
    
    /*
    20, 7, 23, 19, 10, 15, 25, 8, 13
    */
    
    int sum = 0;
    for (int i = 0; i < 9; i++) {
        cin >> input;
        check[input] = 1;
        sum += input;
    }

    int delta = sum - 100;

    vector<int> answer;
    for (int i = 1; i <= 100; i++) {
        // ★★★ 반례발생함. i == delta -i 가 되는 경우 i == delta / 2 인 케이스에 대해 if문 진입을 할 수 없음
        if (check[i] == 1 && check[delta - i] == 0) answer.push_back(i);
    }

    for (auto& ele : answer) cout << ele << "\n";

    //일곱 난쟁이의 키의 합이 100
    //아홉 난쟁이의 키가 주어졌을 때, 백설공주를 도와 일곱 난쟁이를 찾는 프로그램을 작성하시오.
    //아홉 개의 줄에 걸쳐 난쟁이들의 키가 주어진다. 주어지는 키는 100을 넘지 않는 자연수이며, 아홉 난쟁이의 키는 모두 다르며,
    //가능한 정답이 여러 가지인 경우에는 아무거나 출력한다.
    //일곱 난쟁이의 키를 오름차순으로 출력한다. 일곱 난쟁이를 찾을 수 없는 경우는 없다.
}

int main(){
    ios::sync_with_stdio(0); cin.tie(0);
    solution();
    return 0;
}