#include <iostream>
#include <map>
#include <algorithm>
#include <vector>

using namespace std;

// 순열의 시간복잡도 O(N * N!)
int main(){
    vector<int> a = {1, 2, 3, 100, 200}; 
    sort(a.begin(), a.end());

    map<vector<int>, int> myMap;

    do{
        vector<int> key;
        for (int i = 0; i < 2; i++) {
            key.push_back(a[i]);
        }
        myMap[key] = 1;
    }while(next_permutation(a.begin(), a.end())); 

    for (auto entry : myMap) {
        for (auto ele  : entry.first) {
            cout << ele << " ";
        }
        cout << "\n";
    }

    return 0; 
} 