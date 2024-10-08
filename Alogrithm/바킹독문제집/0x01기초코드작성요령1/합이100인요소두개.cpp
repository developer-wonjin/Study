#include<bits/stdc++.h>
using namespace std;

// O(N^2) 안좋은 풀이
int solution1(int arr[], int size) {
    for (int i=0; i<size; i++) {
        for (int j=i+1; j<size; j++) {
            if (arr[i] + arr[j] == 100)return 1;
        }
    }
    return 0;
}

// O(N)으로 풀 수 있음
int solution2(int arr[], int size) {
    int check[101] = {};
    for (int i = 0; i < size; i++){
        int ele = arr[i];
        if (check[100-ele] == 1)return 1;
        check[ele] = 1;
    }
    return 0;
}

int main(){
    ios::sync_with_stdio(0); cin.tie(0);

    int arr[] = {1, 52, 48};
    // int arr[] = {50, 42};
    // int arr[] = {4, 13, 63, 87};
    int size = sizeof(arr)/sizeof(arr[0]);

    // cout << solution1() << "\n";
    cout << solution2(arr, size) << "\n";

    return 0;
}