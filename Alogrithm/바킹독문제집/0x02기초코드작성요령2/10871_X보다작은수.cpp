#include<bits/stdc++.h>
using namespace std;

void solution1(){
    int N, X;
    int arr[10004];

    cin >> N >> X;
    for (int i=0; i<N; i++)cin >> arr[i];

    vector<int> v;
    for (int i=0; i<N; i++) {
        int ele = arr[i];
        if (ele < X) v.push_back(ele);        
    }

    for (auto ele : v) cout << ele << " ";
}

int main() {

    ios::sync_with_stdio(0); cin.tie(0);

    solution1();

    return 0;
}