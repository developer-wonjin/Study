#include <string>
#include <vector>
#include <stack>
using namespace std;

string solution(int n, int k, vector<string> cmds) {

    stack<int> deleted;
    vector<int> up;
    vector<int> down;

    for (int i = 0; i < n + 2; i++){
        up.push_back(i - 1);
        down.push_back(i + 1);
    }

    k++;

    for (auto cmd : cmds) {
        if (cmd[0] == 'C') {
            deleted.push(k);
            down[up[k]] = down[k];
            up[down[k]] = up[k];

            if (down[k] == n + 1) k = up[k];
            else k = down[k];
        }

        else if (cmd[0] == 'Z'){
            int restore = deleted.top();deleted.pop();
            down[up[restore]] = restore;
            up[down[restore]] = restore;
        }

        else {
            int jump = stoi(cmd.substr(2));
            if (cmd[0] == 'U') {
                for (int i = 0; i < jump; i++){
                    k = up[k];
                }
            }
            else {
                for (int i = 0; i < jump; i++){
                    k = down[k];
                } 
            }
        }
    }

    string answer = string(n, 'O');

    //answer.append(n, '0');

    while(deleted.size()) {
        answer[deleted.top() - 1] = 'X';
        deleted.pop();
    }

    return answer;
}

#include<iostream>

int main(){

    cout << solution(8, 2, 	{"D 2","C","U 3","C","D 4","C","U 2","Z","Z"}) << "\n";
    cout << solution(8, 2, 	{"D 2","C","U 3","C","D 4","C","U 2","Z","Z","U 1","C"}) << "\n";

    return 0;
}