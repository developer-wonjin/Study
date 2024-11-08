#include<vector>
#include<string>
#include<iostream>

using namespace std;

string preOrder(const vector<string>& nodes, int idx) {
    if (idx >= nodes.size()) {
        return "";
    }

    string ret = "";
    ret += nodes[idx] + " ";
    ret += preOrder(nodes, idx * 2);
    ret += preOrder(nodes, idx * 2 + 1);
    return ret;
}

string inOrder(const vector<string>& nodes, int idx) {
    if (idx >= nodes.size()) {
        return "";
    }
    cout << idx << " ";
    string ret = "";
    ret += inOrder(nodes, idx * 2);
    ret += nodes[idx] + " ";
    ret += inOrder(nodes, idx * 2 + 1);
    return ret;
}

string postOrder(const vector<string>& nodes, int idx) {
    if (idx >= nodes.size()) {
        return "";
    }

    string ret = "";
    ret += postOrder(nodes, idx * 2);
    ret += postOrder(nodes, idx * 2 + 1);
    ret += nodes[idx] + " ";
    return ret;
}

vector<string> solution(vector<string> nodes) {
    vector<string> ret;
    ret.push_back(preOrder(nodes, 1));
    ret.push_back(inOrder(nodes, 1));
    ret.push_back(postOrder(nodes, 1));
    return ret;
}

int main() {
    const vector<string>& ret = solution(
        {"", "A","B","C","D","E","F","G"}
    );
    for (auto& ele : ret) {
        cout << "\n" << ele;
    }
    return 0;
}