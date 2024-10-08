#include <iostream>
#include <string>
#include <stack>

using namespace std;

int len;
int res;

bool notMatch(char ele, char ch) {
    if (ele == '(' && ch == ')') return false;
    if (ele == '[' && ch == ']') return false;
    if (ele == '{' && ch == '}') return false;
    return true;
}

void solve(string &newS) {
    stack<char> stk;
    
    for (int j = 0; j < len; j++) {
        char newCh = newS[j];
        if (newCh == '(' || newCh == '[' || newCh == '{') {
            stk.push(newCh);
        } else if (stk.empty() || notMatch(stk.top(), newCh)) {
            return;
        } else {
            stk.pop();
        }
    }

    if (stk.size() == 0) {
        res++;
    }
}

int solution(string s) {
    len = s.length();
    
    for (int i = 0; i < len; i++) {
        s = s.substr(1) + s[0];
        solve(s);
    }

    return res;
}