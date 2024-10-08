//해설
//https://www.acmicpc.net/source/share/5cbef80aaad4484a8c3ea73bebf2c0ab
//https://www.acmicpc.net/source/share/6b0acb8d4af043f88800c74b72d77610
//https://www.acmicpc.net/source/share/2da2c198ee3744e2babea1986b2fffd6

#include<bits/stdc++.h>

using namespace std;

int a[9] = {};
vector<int> v;
int n = 9;
int r = 7;

void printV(){
    for (auto ele : v) cout << ele << "\n";
}

void makeCombi(int start) {

    if (v.size() == r) {

        int sum = 0;
        for (auto ele : v) sum += ele;
        if(sum == 100) {
            printV();
            exit(0);
        }
    }

    for (int i = start + 1; i < n; i++){
        v.push_back(a[i]);
        makeCombi(i);
        v.pop_back();
    }
}

void solution(){
    for (int i = 0; i < 9; i++) cin >> a[i];
    sort(a, a+9);
    makeCombi(-1);

}

int main(){
    ios::sync_with_stdio(0); cin.tie(0);
    solution();
    return 0;
}