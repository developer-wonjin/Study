#include <vector>
#include <algorithm>

using namespace std;

bool cmp(const pair<int, double>& a, const pair<int, double>& b){
    if (a.second == b.second){
        return a.first < b.first;
    }
    return a.second > b.second;
}

vector<int> solution(int N, vector<int> stages) {
    vector<int> answer;

    vector<int> notClear(N+1);
    vector<int> trying(N+1);

    for (int stage : stages){
        for (int i = 1; i <= stage; i++) trying[i]++;

        // 5 
        // [2, 1, 2, 6, 2, 4, 3, 3]

        // [0, 1, 2, 3, 4, 5]
        //  X  4  3  1  1  1       

        notClear[stage]++;
    }

    vector<pair<int, double>> v;
    for (int i = 1; i <= N; i++){
        if (trying[i] == 0) {
            v.push_back({i, 0.0});
        } else {
            v.push_back({i, (double)notClear[i]/trying[i]});
        }
    }

    sort(v.begin(), v.end(), cmp);

    for(auto& ele : v) answer.push_back(ele.first);

    return answer;
}