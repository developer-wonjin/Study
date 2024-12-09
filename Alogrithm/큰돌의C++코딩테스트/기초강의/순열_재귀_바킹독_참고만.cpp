#include <bits/stdc++.h>

using namespace std;

int n, m;
int arr[10];
bool isused[10];

void func(int depth) {


    // cout << "isused: ";
    // for (int i = 0; i <= n; i++) cout << isused[i] << " ";
    // cout << "\n\n";

    if (depth == m) {

        // cout << "depth: " << depth << "\n";
        cout << "arr: \t";
        for (int i = 0; i < m; i++) cout << arr[i] << " ";
        cout << "\n";

        // cout << "==> 정답\n";
        return;
    }
    
    for (int i = 0; i < n; i++) {
        if (isused[i + 1])continue;
        arr[depth] = i + 1;
        isused[i + 1] = 1;
        func(depth + 1);
        isused[i + 1] = 0;
        arr[depth] = 0;
    }
}

int main(void) {
    ios::sync_with_stdio(0); cin.tie(0);

    n = 4; m = 3;
    func(0);
}