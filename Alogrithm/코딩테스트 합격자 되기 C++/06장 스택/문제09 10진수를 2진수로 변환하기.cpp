#include <bits/stdc++.h>

using namespace std;

string solution(int decimal){
    stack<int> stk;
    while(decimal > 1){
        int q = decimal % 2;
        stk.push(q);
        decimal /= 2;
    }
    stk.push(1);

    string s;
    while(stk.empty() == false){
        s += to_string(stk.top());
        cout << s << "\n";
        stk.pop();
    }
    return s;
}

int main(){
    cout << solution(10) << "\n";
    return 0;
}