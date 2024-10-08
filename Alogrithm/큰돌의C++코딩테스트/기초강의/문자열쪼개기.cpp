#include<bits/stdc++.h>

using namespace std;

vector<string> split (string &str, string delimeter) {
    vector<string> splits;

    // 시작과 끝 업데이트
    int start = 0;
    int end = str.find(delimeter);

    while(end != string::npos) {
        // 구분값을 저장
        splits.push_back(str.substr(start, end - start));

        // 시작과 끝 업데이트
        start = end + delimeter.size();
        end = str.find(delimeter, start);
    }

    // 구분값을 저장
    splits.push_back(str.substr(start));
    return splits;
}

int main() {

    string str = "apple=>banana=>orange=>grape";
    vector<string> fruits = split(str, "=>");
    for(auto ele : fruits) {
        cout << ele << " ";
    }

    return 0;
}