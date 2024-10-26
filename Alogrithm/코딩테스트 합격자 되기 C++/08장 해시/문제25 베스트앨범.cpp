#include <string>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

unordered_map<string, int> genreMap;
vector<int> g_plays;
vector<string> g_genres;
bool cmp (int a, int b) {
    if (genreMap[g_genres[a]] == genreMap[g_genres[b]]) {
        if (g_plays[a] == g_plays[b]) {
            return a < b;
        }
        return g_plays[a] > g_plays[b];
    }
    return genreMap[g_genres[a]] > genreMap[g_genres[b]];
}

vector<int> solution(vector<string> genres, vector<int> plays) {
    vector<int> answer;
    g_plays = plays;
    g_genres = genres;
    int n = genres.size();
    for (int i = 0; i < n; i++) {
        genreMap[genres[i]] += plays[i];
    }

    vector<int> v;// 고유번호
    for (int i = 0; i < n; i++) v.push_back(i);
    sort(v.begin(), v.end(), cmp);

    unordered_map<string, int> genreFreqMap;
    for (auto ele : v) {
        string genre = genres[ele];
        if (genreFreqMap[genre] == 2) continue;
        genreFreqMap[genre]++;
        answer.push_back(ele);
    }

    return answer;
}