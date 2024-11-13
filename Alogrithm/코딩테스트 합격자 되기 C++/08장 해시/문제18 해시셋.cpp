//https://www.acmicpc.net/problem/3273

#include<bits/stdc++.h>

using namespace std;
/*
9
5 12 7 10 9 1 2 3 11
13

3
*/
int input;
int n, x;
vector<int> v;
unordered_set<int> uset;
int res;
// 128MB = 128_000_000 byte = 4byte * 32000000 개
int main(){

    ios::sync_with_stdio(0); cin.tie(0);

    cin >> n;

    for (int i = 0; i < n; i++){
        int temp;
        cin >> temp;
        v.push_back(temp);
    }
    cin >> x;


    for (int ele : v) {
        int target = x - ele;
        if (uset.find(target) != uset.end()) {
            res++;
        }

        uset.insert(ele);
    }

    cout << res;
    return 0;
}