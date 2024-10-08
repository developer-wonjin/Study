#include<bits/stdc++.h>

using namespace std;

int a[9] = {};

int main(){
    ios::sync_with_stdio(0); cin.tie(0);

    for (int i = 0 ; i < 9; i ++) cin >> a[i];

    // ★★★★★ do ~ while사용할 때는 무조건 sort부터 시켜준다. ★★★★
    sort(a, a+9);
    do {
        int sum = 0;
        for(int i = 0; i < 7; i++) sum += a[i];
        if(sum == 100)break;
    } while (next_permutation(a, a + 9));

    for(int i = 0; i < 7; i++) cout << a[i] << "\n";

    return 0;
}