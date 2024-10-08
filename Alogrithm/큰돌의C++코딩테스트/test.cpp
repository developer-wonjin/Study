#include<bits/stdc++.h>
using namespace std;

int main()
{
    ios::sync_with_stdio(0); cin.tie(0);

    vector<int> v = {0, 1, 2, 3, 4};

    auto it = v.insert(v.begin() + 1, 100);

    for(auto& ele : v)cout << ele << " ";

    return 0;
}