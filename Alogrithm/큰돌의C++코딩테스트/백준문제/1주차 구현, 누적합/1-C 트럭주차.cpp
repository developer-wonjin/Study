#include<bits/stdc++.h>

using namespace std;
/*
문제
상근이는 트럭을 총 세 대 가지고 있다.

주차하는 트럭의 수에 따라서 주차 요금을 할인

한 대  주차할 때는 1분에 한 대당 A원
두 대  주차할 때는 1분에 한 대당 B원
세 대  주차할 때는 1분에 한 대당 C원

A, B, C가 주어지고, 상근이의 트럭이 주차장에 주차된 시간이 주어졌을 때, 주차 요금으로 얼마를 내야 하는지 구하는 프로그램을 작성하시오.

입력
첫째 줄에 문제에서 설명한 주차 요금 A, B, C가 주어진다. (1 ≤ C ≤ B ≤ A ≤ 100)

다음 세 개 줄에는 두 정수가 주어진다. 
이 정수는 상근이가 가지고 있는 트럭이 '주차장에 도착한 시간'과 '주차장에서 떠난 시간'
도착한 시간은 항상 떠난 시간보다 앞선다. 
입력으로 주어지는 시간은 1과 100사이 이다.


출력
첫째 줄에 상근이가 내야하는 주차 요금을 출력한다.

예1)
5 3 1
1 6
3 5
2 8

33

예2)
10 8 6
15 30
25 50
70 80

480
*/

int cnts[101];
int a,b,c;

int main() {
    ios::sync_with_stdio(0); cin.tie(0);

    cin >> a >> b >> c;

    for (int i = 0; i < 3; i++) {
        int x, y;
        cin >> x >> y;
        for (int j = x; j < y; j++){
            cnts[j]++;
        }
    }

    int tot = 0;
    for (auto& ele : cnts) {
        if (ele == 1) {
            tot += ele * a;
        } else if (ele == 2) {
            tot += ele * b;
        } else {
            tot += ele * c;
        }
    }

    cout << tot;

    return 0;
}