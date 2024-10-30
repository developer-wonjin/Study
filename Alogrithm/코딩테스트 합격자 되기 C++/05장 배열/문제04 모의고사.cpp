//https://school.programmers.co.kr/learn/courses/30/lessons/42840
#include<bits/stdc++.h>

using namespace std;

vector<vector<int>> stuAnswers = {
    {1,2,3,4,5},
    {2,1,2,3,2,4,2,5},
    {3,3,1,1,2,2,4,4,5,5}
};

bool cmp(const pair<int, int> &a, const pair<int, int> &b){
    if (a.second == b.second){
        return a.first < b.first;
    }
    return a.second < b.second;
}

vector<int> solution2(vector<int> answers) {
    vector<int> answer;
    vector<int> scores(3);// {0, 0, 0}
    
    // O(N)
    for (int stuNum = 0; stuNum < stuAnswers.size(); stuNum++){
        vector<int>& stuAnswer = stuAnswers[stuNum];
        int t = stuAnswer.size();
        for (int i = 0; i < answers.size(); i++){

            //i   0 1 2 3 4 5 6 7 8
            //i%t 0 1 2 3 4 0 1 2 3             
            if (answers[i] == stuAnswer[i%t])scores[stuNum]++; 
        }
    }

    // O(N)
    int maxScore = *max_element(scores.begin(), scores.end());
    for (int i = 0; i < 3; i++){
        if (scores[i] == maxScore) answer.push_back(i+1);
    }
}

vector<int> solution1(vector<int> answers) {
    
    vector<pair<int, int>> result; // 학생-점수
    int maxScore = 0;
    for (int stuNum = 0; stuNum < stuAnswers.size(); stuNum++){
        vector<int>& v = stuAnswers[stuNum];
        int t = v.size();
        int score = 0;
        for (int i = 0; i < answers.size(); i++){
            if (answers[i] == v[i%t])score++; 
        }

        maxScore = max(maxScore, score);
        result.push_back({stuNum+1, score});
    }

    sort(result.begin(), result.end(), cmp);

    vector<int> answer;

    for (const auto& p : result){
        if (p.second < maxScore)continue;
        answer.push_back(p.first);
    }

    return answer;
}

int main(){
    ios::sync_with_stdio(0); cin.tie(0);



    return 0;
}