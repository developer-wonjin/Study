#include<vector>
#include<string>
#include<iostream>

using namespace std;

string preOrder(const vector<string>& nodes, int idx) {
    // 등호가 있어야함
    if (idx >= nodes.size()) {
        return "";
    }

    string ret = "";

    // -1하지 않고 idx를 그대로 사용할 수 있음
    ret += nodes[idx] + " ";

    // 공식에 수정이 좀 있음
    ret += preOrder(nodes, idx * 2 + 1);
    ret += preOrder(nodes, idx * 2 + 2);
    return ret;
}

string inOrder(const vector<string>& nodes, int idx) {
    if (idx >= nodes.size()) {
        return "";
    }
    cout << idx << " ";
    string ret = "";
    ret += inOrder(nodes, idx * 2 + 1);
    ret += nodes[idx] + " ";
    ret += inOrder(nodes, idx * 2 + 2);
    return ret;
}

string postOrder(const vector<string>& nodes, int idx) {
    if (idx >= nodes.size()) {
        return "";
    }

    string ret = "";
    ret += postOrder(nodes, idx * 2 + 1);
    ret += postOrder(nodes, idx * 2 + 2);
    ret += nodes[idx] + " ";
    return ret;
}

vector<string> solution(vector<string> nodes) {
    vector<string> ret;
    ret.push_back(preOrder(nodes, 0));
    ret.push_back(inOrder(nodes, 0));
    ret.push_back(postOrder(nodes, 0));
    return ret;
}

int main() {
    const vector<string>& ret = solution(
        {"A","B","C","D","E","F","G"}
    );
    for (auto& ele : ret) {
        cout << "\n" << ele;
    }
    return 0;
}