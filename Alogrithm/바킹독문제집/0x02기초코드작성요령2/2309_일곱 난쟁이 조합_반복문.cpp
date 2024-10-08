#include<bits/stdc++.h>

using namespace std;

int a[9], sum;
vector<int> v;
int x, y;

void solution(){
    for (int i = 0; i < 9; i++) {
        for (int j = i + 1; j < 9; j++){
            if(sum - a[i] - a[j] == 100){
                x = i;
                y = j;
                return;
            }
        }
    }
}

int main(){
    ios::sync_with_stdio(0); cin.tie(0);
    
    for (int i = 0; i < 9; i++){
        cin >> a[i];
        sum += a[i];
    }

    solution();

    for (int i = 0; i < 9; i++) {
        if (i == x || i == y) continue;
        v.push_back(a[i]);
    }

    sort(v.begin(), v.end());
    for(auto ele : v) cout << ele << " ";
    return 0;
}