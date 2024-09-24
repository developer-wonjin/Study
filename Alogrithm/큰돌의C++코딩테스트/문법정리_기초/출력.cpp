#include<bits/stdc++.h>
using namespace std;

int main () {
    ios::sync_with_stdio(0);
    cin.tie(NULL); cout.tie(NULL);

    // cin으로 실수 타입 소수점 이하 갯수 지정하기
    double a = 1.23456789;
    cout << a << "\n";
    cout << fixed << setprecision(3) << a << "\n";
    cout << fixed << setprecision(8) << a << "\n";
    printf("%.8lf\n", a);

    return 0;
}