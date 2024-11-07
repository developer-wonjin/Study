#include<bits/stdc++.h>

using namespace std;

int r = 3;

vector<int> ret;
void combi(string str) {

    cout << str << "\n";


    if (ret.size() == r) {
        return;
    }
    //str        ret
    //abcd       
    //           a
    //bcd        a
    //bcd        a

    for (int i = 0; i < str.size(); i++) {
        ret.push_back(str[i]);
        combi(str.substr(i+1));
        ret.pop_back();
    }
}

int main() {
    combi("abcd");

    return 0;
}