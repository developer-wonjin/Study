#include<string>
#include<stack>
using namespace std;

int solution(string s)
{
    int answer = -1;
    
    stack<char> stk;
    // for (char& c : s){
    //     if (stk.empty()){
    //         stk.push(c);
    //     } else {
    //         char top = stk.top();
    //         if (top == c)stk.pop();
    //         else stk.push(c);
    //     }
    // }

    // 리팩토링
    for (char& c : s){
        if (stk.empty() || stk.top() != c){
            stk.push(c);
        } else {
            stk.pop();
        }
    }    

    return stk.empty();
}