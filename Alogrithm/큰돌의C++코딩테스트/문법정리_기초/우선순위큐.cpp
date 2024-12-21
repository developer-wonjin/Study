#include<bits/stdc++.h>

using namespace std;

struct Node{
    int y,x;
};

struct cmp {
    bool operator()(Node a, Node b) {
        return a.y > b.y;
    }
};
priority_queue<Node, vector<Node>, cmp> pq;
int main() {
    pq.push({5, 1});
    pq.push({4, 1});
    pq.push({7, 1});
    pq.push({1, 1});
    pq.push({2, 1});
    pq.push({3, 1});
    pq.push({4, 1});

    while(pq.size()) {
        cout << pq.top().y << "\n"; 
        pq.pop();
        
    }

    return 0;
}