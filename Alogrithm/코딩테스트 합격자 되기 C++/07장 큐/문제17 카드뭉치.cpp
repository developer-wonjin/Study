#include <string>
#include <vector>
#include <queue>
#include <iostream>
using namespace std;
/*
카드 뭉치 두 개
원하는 순서의 단어 배열을 만들 수 있는지

원하는 카드 뭉치에서 카드를 순서대로 한 장씩 사용합니다.
한 번 사용한 카드는 다시 사용할 수 없습니다.
카드를 사용하지 않고 다음 카드로 넘어갈 수 없습니다.

기존에 주어진 카드 뭉치의 단어 순서는 바꿀 수 없습니다.
예를 들어 

첫 번째 카드 뭉치에 순서대로 ["i", "drink", "water"], 
두 번째 카드 뭉치에 순서대로 ["want", "to"]

["i", "want", "to", "drink", "water"] 순서의 단어 배열을 만들려고 한다면 
첫 번째 카드 뭉치에서 "i"를 사용한 후 
두 번째 카드 뭉치에서 "want"와 "to"를 사용하고 
첫 번째 카드뭉치에 "drink"와 "water"를 차례대로 사용하면 원하는 순서의 단어 배열을 만들 수 있습니다.

문자열로 이루어진 배열 cards1, cards2와 원하는 단어 배열 goal이 매개변수로 주어질 때, 
cards1과 cards2에 적힌 단어들로 goal를 
만들 있다면 "Yes"를, 
만들 수 없다면 "No"를 return하는 solution 함수를 완성해주세요.
*/
string solution(vector<string> cards1, vector<string> cards2, vector<string> goal) {
    string answer = "";
    
    queue<string> q1, q2;
    queue<string> g;
    
    for (string& card1 : cards1)q1.push(card1);
    for (string& card2 : cards2)q2.push(card2);
    for (string& ele : goal)g.push(ele);
    
    
    
    while(g.size()){
        string gEle = g.front(); g.pop();
        
        if (q1.size() && q1.front() == gEle){
            q1.pop();
        } else if (q2.size() && q2.front() == gEle){
            q2.pop();
        } else {
            return "No";
        }
    }
        
    return "Yes";
}