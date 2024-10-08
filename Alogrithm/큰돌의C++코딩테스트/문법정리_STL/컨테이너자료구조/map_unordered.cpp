#include<bits/stdc++.h>

using namespace std;



int main(){
    ios::sync_with_stdio(0); cin.tie(0);

    unordered_map<string, int> address;

    address.insert({"A", 1000});
    address.insert({"B", 1000});
    address.insert({"C", 1000});
    address.insert({"D", 1000});

    for (auto ele : address) {
        cout << ele.first << ", " << ele.second << "\n";
    }

    address["A"] = 3000;
    address.erase("B");
    address["a"];

    auto it = address.find("wonjin");
    if (it == address.end()) cout << "못찾음" << "\n";
    
    for (auto it = address.begin(); it != address.end(); it++){
        auto ele = *it;
        cout << ele.first << ", " << ele.second << "\n";
    }

    return 0;
}