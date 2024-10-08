//https://school.programmers.co.kr/learn/courses/30/lessons/64061
#include <string>
#include <vector>
#include <stack>
using namespace std;
/*
 각 격자 칸에는 다양한 인형이 들어 있으며
 인형이 없는 칸은 빈칸입니다.
 모든 인형은 "1 x 1" 크기의 격자 한 칸을 차지
 격자의 가장 아래 칸부터 차곡차곡 쌓여 있습니다. 
 게임 사용자는 크레인을 좌우로 움직여서 멈춘 위치에서
 가장 위에 있는 인형을 집어 올릴 수 있습니다. 
 집어 올린 인형은 바구니에 쌓이게 되는 데, 
 이때 바구니의 가장 아래 칸부터 인형이 순서대로 쌓이게 됩니다.
 다음 그림은 [1번, 5번, 3번] 위치에서 순서대로 인형을 집어 올려 
 바구니에 담은 모습입니다.
*/
#include <iostream>
int cnt;
stack<int> sections[31];
stack<int> basket;
int solution(vector<vector<int>> board, vector<int> moves) {
    

    for (auto it = board.rbegin(); it != board.rend(); it++){
        vector<int>& boardPart = *it;
        for (int col = 0; col < boardPart.size(); col++){
            if (boardPart[col] > 0)sections[col].push(boardPart[col]);
        }
    }

    for (int i = 0; i < board.size(); i++) cout << sections[i].size() << " ";
    cout << "\n";

    for (int& move : moves){
        int col = move - 1;
        stack<int>& section = sections[col];
        
        if (section.empty()) continue;
        
        if ( !basket.empty() && basket.top() == section.top()) {
                basket.pop();
                cnt += 2;
        } else {
            basket.push(section.top()); 
        }
        section.pop();
    }

    for (int i = 0; i < board.size(); i++) cout << sections[i].size() << " ";
    cout << "\n";

    return cnt;
}


int main(){

    cout << solution({{0,0,0,0,0},{0,0,1,0,3},{0,2,5,0,1},{4,2,4,4,2},{3,5,1,3,1}}
    , {1,5,3,5,1,2,1,4}) << "\n";

    cout << basket.size() << "\n";
    return 0;
}