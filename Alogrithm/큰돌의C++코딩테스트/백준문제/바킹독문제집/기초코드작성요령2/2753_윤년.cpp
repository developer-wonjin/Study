#include<bits/stdc++.h>

using namespace std;

int solution(int year) {
    if (year % 4 == 0 && (year % 100 > 0 || year % 400 == 0)) return 1;
    return 0;
}

int main(){
    ios::sync_with_stdio(0); cin.tie(0);

    int year;

    cin >> year;

    cout << solution(year);
}