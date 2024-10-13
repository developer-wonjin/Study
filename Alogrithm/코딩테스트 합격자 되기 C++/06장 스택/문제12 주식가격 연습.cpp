#include <string>
#include <vector>
#include <stack>

#include <iostream>
#include <iterator>

using namespace std;

stack<int> stk;
vector<int> solution(vector<int> prices) {
    int n = prices.size();
    vector<int> ans(n);

    for (int i = 0; i < prices.size(); i++){
        while(stk.size() && prices[stk.top()] > prices[i]) {
            ans[stk.top()] = i - stk.top();
            stk.pop();
        }
        stk.push(i);
    }

    while(stk.size()){
        ans[stk.top()] = (n-1) - stk.top();
        stk.pop();
    }

    return ans;
}

void print(vector<int> vec)
{
    for (auto ele : vec) cout << ele << " ";
    cout << endl;
}

int main()
{
    print(solution({1, 6, 9, 5}));
    return 0;
}