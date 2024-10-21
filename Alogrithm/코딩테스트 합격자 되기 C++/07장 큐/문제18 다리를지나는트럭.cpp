#include <string>
#include <vector>
#include <queue>
#include <iostream>
using namespace std;
/*
트럭 여러 대 일차선 다리를 정해진 순으로 건너
모든 트럭이 다리를 건너려면 최소 몇 초가 걸리는지

bridge_length: 다리에 올라갈 수 있는 트럭의 최대 갯수
weight       : 다리가 견딜 수 있는 최대무게
단, 다리에 완전히 오르지 않은 트럭의 무게는 무시합니다.

예를 들어, 트럭 2대가 올라갈 수 있고 무게를 10kg까지 견디는 다리가 있습니다. 
무게가 [7, 4, 5, 6]kg인 트럭이 순서대로 최단 시간 안에 다리를 건너려면 다음과 같이 건너야 합니다.


*/
int solution(int bridge_length, int weight, vector<int> truck_weights) {
    int answer = 0;
    queue<int> ing, wait;
    vector<int> pass;
    
    int n = truck_weights.size();
    
    for (int i = 0; i < bridge_length; i++)ing.push(0);
    
    for (auto truck : truck_weights) {
        wait.push(truck);
    }
    
    int currWeight = 0; //다리에 올라간 트럭 전체무게
    int cnt = 0;        //다리에 올라간 트럭 갯수
    
    
    while(pass.size() < n) {
        answer++;
        int ingF = ing.front(); ing.pop();
        if (ingF > 0){
            currWeight -= ingF;
            cnt--;
            pass.push_back(ingF);
        }
        
        if (wait.size() && currWeight + wait.front() <= weight){
            ing.push(wait.front()); 
            currWeight += wait.front();
            wait.pop();
            cnt++;
        } else {
            ing.push(0);
        }
    }
    
    
    return answer;
}