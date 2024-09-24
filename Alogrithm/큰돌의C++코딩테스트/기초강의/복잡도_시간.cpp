#include<bits/stdc++.h>

using namespace std;

int func1(int n) {
    int sum = 0;

    for (int i = 1; i <= n; i++) {
        if (i % 3 == 0 || i % 5 == 0) {
            sum += i;
        }
    }
    return sum;
}

// O(N^2) 풀이임... 추후 O(N) 풀이로 발전시켜보자
int func2(int arr [], int N) {
    for (int i = 0; i < N; i++) {
        for (int j = i + 1; j < N; j++)  {
            if (arr[i] + arr[j] == 100)return 1;
        }
    }
    return 0;
}

int func3(int N) {
    for (int i = 1; i * i <= N; i++){
        if (i * i == N) return 1;
    }
    return 0;
}

int func4(int N) {
    int val = 1;

    while (val <= N) {
        val *= 2;
    }
    return val/2;
}

int func4_더좋음(int N) {
    int val = 1;

    while (val * 2 <= N) {
        val *= 2;
    }
    return val;
}

int main(){
    ios::sync_with_stdio(0); cin.tie(NULL); cout.tie(NULL);

    // cout << func1(16) << "\n";
    // cout << func1(34567) << "\n";
    // cout << func1(27639) << "\n";

    // int arr1[] = {1, 52, 48};
    // int arr2[] = {52, 42};
    // int arr3[] = {4, 13, 63, 87};
    // cout << func2(arr1, 3) << "\n";
    // cout << func2(arr2, 2) << "\n";
    // cout << func2(arr3, 4) << "\n";

    cout << func3(9) << "\n";
    cout << func3(693953651) << "\n";
    cout << func3(756580036) << "\n";

    cout << func4(5) << "\n";
    cout << func4(97615282) << "\n";
    cout << func4(1024) << "\n";
    return 0;
}