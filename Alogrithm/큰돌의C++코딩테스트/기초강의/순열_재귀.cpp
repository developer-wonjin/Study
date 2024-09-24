#include<iostream>
#include<vector>
#include<algorithm>

using namespace std;

vector<int> v = {0, 1, 2, 3};
int n = 4;
int r = 1;

void printV(vector<int> &v) {
    for (int i = 0; i < r; i++) {
        cout << v[i] << " ";
    }
    cout << "\n";
}

void makePermutation(int depth){
    // cout << depth << "\n";
    
    if (r == depth) {
        printV(v);
        return;
    }

    for (int i = depth; i < n; i++) {
        swap(v[depth], v[i]);
        makePermutation(depth+1);
        swap(v[depth], v[i]);
    }
}

int main() {
    makePermutation(0);

    return 0;
}