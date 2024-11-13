#include <string>
#include <vector>
#include <unordered_map>
#include <iostream>
using namespace std;
unordered_map<string, int> umap;
string solution(vector<string> participant, vector<string> completion) {
    for (string& ele : completion) {
        umap[ele] = 1;
    }

    for (string& ele : participant) {
        if (umap.find(ele) == umap.end()) return ele;
    }
    return "";
}

int main() {

    cout << solution(
        {"leo", "kiki", "eden"},
        {"eden", "kiki"}
    ) << "\n";

    cout << solution(
        {"marina", "josipa", "nikola", "vinko", "filipa"},
        {"josipa", "filipa", "marina", "nikola"}
    ) << "\n";

    cout << solution(
        {"mislav", "stanko", "mislav", "ana"},
        {"stanko", "ana", "mislav"}
    ) << "\n";

    return 0;
}