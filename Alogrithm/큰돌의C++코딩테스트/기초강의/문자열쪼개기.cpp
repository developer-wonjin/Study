#include<bits/stdc++.h>

using namespace std;

vector<string> split (string &str, string delimeter) {
    vector<string> splits;

    int start = 0;
    int end = str.find(delimeter);
    while(end != string::npos){
        splits.push_back(str.substr(start, end - start));
        start = end + delimeter.size();
        end = str.find(delimeter, start);
    }
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