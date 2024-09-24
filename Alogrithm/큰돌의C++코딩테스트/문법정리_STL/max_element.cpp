#include<bits/stdc++.h>

using namespace std;

// 잘못된 풀이
int wrongSolution(int arr []){
    if(arr[0] > arr[1] && arr[0] > arr[2] && arr[0] > arr[3])
        return arr[0];
    if(arr[1] > arr[0] && arr[1] > arr[2] && arr[1] > arr[3])
        return arr[1];
    if(arr[2] > arr[0] && arr[2] > arr[1] && arr[2] > arr[3])
        return arr[2];
    return arr[3];
}

int solution1(int arr[]) {
    int myMax = arr[0];
    for (int i = 0; i < 4; i++) {
        if (arr[i] > myMax) myMax = arr[i];
    }
    return myMax;
}

int solution2(int arr[]){
    return *max_element(arr, arr+4);
}

int main(){

    ios::sync_with_stdio(0); cin.tie(NULL); cout.tie(NULL);

    int arr[] = {9, 9, 3, 1};
    cout << wrongSolution(arr) << "\n";
    cout << solution1(arr) << "\n";
    cout << solution2(arr) << "\n";
    return 0;
}