#include<vector>
#include<string>
#include<iostream>

using namespace std;

string preOrder(const vector<int>& nodes, int idx) {
    if (idx > nodes.size()) {
        return "";
    }

    string ret = "";
    ret += to_string(nodes[idx-1]) + " ";
    ret += preOrder(nodes, idx * 2);
    ret += preOrder(nodes, idx * 2 + 1);
    return ret;
}

string inOrder(const vector<int>& nodes, int idx) {
    if (idx > nodes.size()) {
        return "";
    }
    cout << idx << " ";
    string ret = "";
    ret += inOrder(nodes, idx * 2);
    ret += to_string(nodes[idx-1]) + " ";
    ret += inOrder(nodes, idx * 2 + 1);
    return ret;
}

string postOrder(const vector<int>& nodes, int idx) {
    if (idx > nodes.size()) {
        return "";
    }

    string ret = "";
    ret += postOrder(nodes, idx * 2);
    ret += postOrder(nodes, idx * 2 + 1);
    ret += to_string(nodes[idx-1]) + " ";
    return ret;
}

vector<string> solution(vector<int> nodes) {
    vector<string> ret;
    ret.push_back(preOrder(nodes, 1));
    ret.push_back(inOrder(nodes, 1));
    ret.push_back(postOrder(nodes, 1));
    return ret;
}

int main() {
    const vector<string>& ret = solution({1,2,3,4,5,6,7});
    for (auto& ele : ret) {
        cout << "\n" << ele;
    }
    return 0;
}