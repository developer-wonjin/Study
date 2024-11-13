//https://www.youtube.com/watch?v=7i4qtozdvks
#include<bits/stdc++.h>

using namespace std;

struct Node {
    int id;
    int x, y;
    Node* left;
    Node* right;
};

bool cmp(Node& a, Node& b) {
    if (a.y == b.y)return a.x < b.x;
    return a.y > b.y;
}

void addNode(Node* parent, Node* child) {
    if (child->x < parent->x) {
        if (parent->left == NULL) parent->left = child;
        else addNode(parent->left, child);
    } else {
        if (parent->right == NULL) parent->right = child;
        else addNode(parent->right, child);
    }
}

void preorder(vector<int>&ans, Node* node) {
    if (node == NULL) return;

    ans.push_back(node->id);
    preorder(ans, node->left);
    preorder(ans, node->right);
}


void postorder(vector<int>&ans, Node* node) {
    if (node == NULL) return;

    postorder(ans, node->left);
    postorder(ans, node->right);
    ans.push_back(node->id);
}

vector<vector<int>> solution(vector<vector<int>> nodeinfos) {
    int size = nodeinfos.size();
    vector<Node> nodes;
    for (int i = 0; i < size; i++){
        vector<int>& nodeinfo = nodeinfos[i];
        nodes.push_back({i+1, nodeinfo[0], nodeinfo[1]});
    }

    sort(nodes.begin(), nodes.end(), cmp);

    Node* root = &nodes[0];
    for (int i = 1; i < nodes.size(); i++) {
        addNode(root, &nodes[i]);
    }

    vector<vector<int>> answer{{}, {}};
    preorder(answer[0], root);
    postorder(answer[1], root);
    return answer;
}