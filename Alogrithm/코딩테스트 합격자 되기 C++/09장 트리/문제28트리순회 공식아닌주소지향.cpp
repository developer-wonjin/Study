#include<bits/stdc++.h>

using namespace std;

/*
노드갯수
노드번호 왼쪽노드번호 오른쪽노드번호 노드의값
5
1 2 3 A
2 4 5 B
3 -1 -1 C
4 -1 -1 D
5 -1 -1 E

       A
     /   \
    B     C
  /  \   
 D    E 
*/

int N;
struct Node{
    int Lidx, Ridx;
    string value;
};
Node nodes[100];

string preOrder(int idx) {
    // cout << idx << "\n";
    // if (nodes[idx].left == -1 && nodes[idx].right == -1){
    //     return "";
    // }

    if (idx <= 0 || idx > N) return "";

    string ret = "";
    ret += nodes[idx].value + " ";
    ret += preOrder(nodes[idx].Lidx);
    ret += preOrder(nodes[idx].Ridx);
    return ret;
}

int main() {
    cin >> N;

    for (int i = 0; i < N; i++){
        int curr, Lidx, Ridx;
        string value;
        cin >> curr >> Lidx >> Ridx >> value;
        nodes[curr].Lidx = Lidx;
        nodes[curr].Ridx = Ridx;
        nodes[curr].value = value;
    }

    // 입력이 잘됐는지 확인
    // for (int i = 1; i <= N; i++) {
    //     cout << i << ": " << nodes[i].left << " " << nodes[i].right << "\n";
    // }

    cout << preOrder(1) << "\n";
    return 0;
}