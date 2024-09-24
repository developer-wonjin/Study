#include<iostream>

using namespace std;

//완전탐색(Brute-Force)

// N개의 숫자 중에서 최솟값을 구하여라
// 10 3 8 4 2 1
const int NMAX = 6;
int a[6] = {10, 3, 8, 4, 2, 1};

int sol_1_1() {
    int myMin = a[0];
    for (int i = 0; i < 6; i++) {
        if (a[i] < myMin) {
            myMin = a[i];
        }
    }
}

// 1~N개의 숫자를 나열하는 모든 경우를 출력하시오
void sol_2_1() {
    for (int i = 1; i <= 3; i++) {
        for (int j = 1; j <= 3; j++) {
            for (int k = 1; k <= 3; k++) {
                if (i != j && j != k && k != i){
                    cout << i << " " << j << " " << k << "\n";
                }
            }
        }
    }
}



int main() {
    sol_2_1();
    return 0;
}