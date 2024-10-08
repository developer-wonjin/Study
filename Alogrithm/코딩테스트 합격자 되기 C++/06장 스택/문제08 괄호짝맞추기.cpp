#include<bits/stdc++.h>

using namespace std;

bool solution(string s){
    // "( () ) ()"
    
    stack<char> stk;

    for (char& c : s){
        if (c == '(') stk.push(c);
        else {
            if (stk.empty()){
                return false;
            } else {
                stk.pop();
            }
        }
    }

    return stk.empty();
}

int main(){

    cout << solution("(())()") << "\n";
    cout << solution("((())()") << "\n";

    return 0;
}