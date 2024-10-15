//https://www.acmicpc.net/problem/1158
#include<bits/stdc++.h>

using namespace std;

int N, K;
queue<int> q;
vector<int> res;
int main(){

    ios::sync_with_stdio(0); cin.tie(0);

    cin >> N >> K;

    for (int i = 0; i < N; i++){
        q.push(i + 1);
    }

    while(q.size()) {
        // K-1 횟수만큼 뺃다넣기
        for (int i = 0; i < K-1; i++){
            int f = q.front(); q.pop();
            q.push(f);
        }

        // K번째는 삭제하기
        int f = q.front(); q.pop();
        res.push_back(f);

        //cout << "삭제된 숫자: " << f << ", qSize: " << q.size() << "\n";
    }

    string ans;

    for (int ele : res){
        // 잘못된 패턴 (한자리 숫자일 경우만 유효함)
        //ans += (char)('0' + ele);
        //ans += ", ";

        ans += to_string(ele) + ", ";
    }

    cout << "<" << ans.substr(0, ans.size() - 2) << ">";


    return 0;
}