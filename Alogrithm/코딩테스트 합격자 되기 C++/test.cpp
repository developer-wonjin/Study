#include <bits/stdc++.h>

using namespace std; // std 네임스페이스 사용

int main() {
    

    map<string, int> myMap = {{"name", 1}, {"height", 2}};
    for (auto& ele1 : myMap) {
        ele1.second++;
    }

    unordered_map<string, int> uMap = {{"name", 1}, {"height", 2}};
    // for (auto& ele2 : uMap) {
    for (pair<const string, int>& ele2 : uMap) {
        ele2.second++;
    }

    
    set<int> mySet = {1, 2};
    // for (const int& ele1 : mySet) {
    for (auto & ele1 : mySet) {
        /* 
        ele1++;//컴파일오류가 발생하는 연산
        */
    }


    unordered_set<int> uSet = {1, 2}; 
    // for (const int& ele2 : uSet) {
    for (auto& ele2 : uSet) {
        /* 
        ele2++;//컴파일오류가 발생하는 연산
        */
    }

    return 0;
}
