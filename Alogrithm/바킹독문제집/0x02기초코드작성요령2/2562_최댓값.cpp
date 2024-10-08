//https://www.acmicpc.net/problem/2562

#include<bits/stdc++.h>

using namespace std;

vector<int> v(9);

int main(){
    ios::sync_with_stdio(0); cin.tie(0);

    for (int i = 0; i < 9; i++){
        cin >> v[i];
    }

    auto it = max_element(v.begin(), v.end());

    cout << *it << "\n";
    cout << it - v.begin() + 1;



    return 0;
}

// 배열풀이
int a[9];
int main2(void){
  ios::sync_with_stdio(0);
  cin.tie(0);

  for(int i = 0; i < 9; i++) cin >> a[i];
  cout << *max_element(a, a+9) << '\n';
  cout << max_element(a, a+9) - a + 1;
}