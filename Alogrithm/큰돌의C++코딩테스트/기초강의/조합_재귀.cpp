#include<bits/stdc++.h>

using namespace std;

int n = 4, r = 3, a[4] = {100,200,300,400};
vector<int> bucket;

void printV() {
    for(auto ele : bucket) cout << ele << " ";
    cout << "\n";
}

void combi(int start) {
    //cout << "(" << start << ")\n";

    if (bucket.size() == r) {
        printV();
        return;
    }

    // 0123       0
    // 0123       0
    for (int i = start + 1; i < n; i++) {
        bucket.push_back(i);
        combi(i);
        bucket.pop_back();
    }
}

int main() {
    combi(-1);

    return 0;
}