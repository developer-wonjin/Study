//https://school.programmers.co.kr/learn/courses/30/lessons/120821

#include <string>
#include <vector>
#include <algorithm>

using namespace std;

vector<int> solution(vector<int> v) {
    reverse(v.begin(), v.end());
    return v;
}