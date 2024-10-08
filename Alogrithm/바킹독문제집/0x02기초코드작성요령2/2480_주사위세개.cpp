#include<bits/stdc++.h>

using namespace std;



bool cmp(pair<int,int> a, pair<int,int> b){
    if (a.second == b.second) {
        return a.first > b.first;
    }
    return a.second > b.second;
}

// 배열에 출연 횟수를 집계한다.
// 주사위값 : 출연횟수를 key-value로 묶어 정렬시킨다.
int solution1() {
    int occur[7] = {};
    int a;

    for (int i = 0; i < 3; i++) {
        cin >> a;
        occur[a]++;
    }

    vector<pair<int, int>> v;

    for (int i = 1; i <= 6; i++) {
        v.push_back({i, occur[i]});
    }

    sort(v.begin(), v.end(), cmp);

    int val = v[0].first;
    int cnt = v[0].second;
    
    if (cnt == 3) return 10000 + val * 1000;
    else if (cnt == 2) return 1000 + val * 100;
    else return val * 100;
}


int solution2() {
    int arr[3];

    cin >> arr[0] >> arr[1] >> arr[2];
    sort(arr, arr + 3);

    // if ~ else 조건문은 상세한 조건이 상단에 오도록 한다.
    // 포괄적인 조건은 하단에 오도록 한다.
    if(arr[0] == arr[2]) return 10000 + arr[0] * 1000;
    else if (arr[0] == arr[1] || arr[1] == arr[2]) return 1000 + arr[1] * 100;
    else return arr[2] * 100;
}

int main(){
    ios::sync_with_stdio(0); cin.tie(0);

    // cout << solution1();
    cout << solution2();

    return 0;
}