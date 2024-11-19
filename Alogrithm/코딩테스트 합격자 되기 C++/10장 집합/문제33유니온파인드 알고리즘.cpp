#include<vector>

using namespace std;

vector<int> parents;
vector<int> ranks;

// 한자리 숫자문자형을 숫자형으로 변환
int charToInt(char c) {
    return c - '0';
}

int find(int x) {
    if (parents[x] == -1) return x;

    parents[x] = find(parents[x]);
    
    return 
}


vector<bool> solution(int k, vector<vector<char>> operations) {
    parents.resize(k, -1);
    ranks.resize(k, 0);
}