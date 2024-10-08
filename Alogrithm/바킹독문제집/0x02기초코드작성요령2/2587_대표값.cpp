#include<bits/stdc++.h>

using namespace std;

void solution(){
    vector<int> v;
    int input, sum = 0;
    for (int i = 0; i < 5; i++){
        cin >> input;
        v.push_back(input);
        sum += input;
    }

    sort(v.begin(), v.end());

    cout << sum / 5 << "\n";
    cout << v[2] << "\n";
    //다섯 개의 자연수가 주어질 때 이들의 평균과 중앙값을 구하는 프로그램을 작성하시오.
    //첫째 줄부터 다섯 번째 줄까지 한 줄에 하나씩 자연수가 주어진다. 주어지는 자연수는 100 보다 작은 10의 배수이다.
    //첫째 줄에는 평균을 출력하고, 둘째 줄에는 중앙값을 출력한다. 평균과 중앙값은 모두 자연수이다.
}

int main(){
    ios::sync_with_stdio(0); cin.tie(0);
    solution();
    return 0;   
}