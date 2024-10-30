#include<bits/stdc++.h>

using namespace std;

vector<int> solution(vector<int> numbers){
    int n = numbers.size();
    
    set<int> s;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++){
            s.insert(numbers[i] + numbers[j]);
        }
    }

    vector<int> v;
    for(const int& ele : s) v.push_back(ele);
    return v;
}

vector<int> combiVec;
set<int> answer;
void combi(int start, int n, int r, const vector<int>& v){
    if (combiVec.size() == r){
        int sum = 0;
        for(const int& ele : combiVec) sum += v[ele];
        answer.insert(sum);
    }

    for(int i = start + 1; i < n; i++) {
        combiVec.push_back(i);
        combi(i, n, r, v);
        combiVec.pop_back();
    }
}

void permutation(int depth, int n, int r, vector<int>& v) {
    if (depth == r) {
        // 모든 요소출력
        return;
    }

    for (int i = depth; i < n; i++){
        swap(v[depth], v[i]);
        permutation(depth + 1, n, r, v);
        swap(v[depth], v[i]);
    }
}

int main(){
    ios::sync_with_stdio(0); cin.tie(0);

    for(const int& ele : solution({2, 1, 3, 4, 1})) cout << ele << " ";
    cout << "\n";
    for(const int& ele : solution({5, 0, 2, 7})) cout << ele << " ";
    cout << "\n";

    combi(-1, 5, 2, {2, 1, 3, 4, 1});
    for(const int& ele : answer) cout << ele << " ";

    return 0;
}