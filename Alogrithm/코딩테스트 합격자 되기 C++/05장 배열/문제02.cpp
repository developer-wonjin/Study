#include<bits/stdc++.h>

using namespace std;

vector<int> solution(vector<int> lst) {
    sort(lst.rbegin(), lst.rend());
    lst.erase(unique(lst.begin(), lst.end()), lst.end());
    return lst;
}

int main(){
    ios::sync_with_stdio(0); cin.tie(0);

    // vector<int> lst = {4, 2, 2, 1, 3, 4};
    vector<int> lst = {2, 1, 1, 3, 2, 5, 4};


    for (int& ele : solution(lst)) cout << ele << " ";

    return 0;
}