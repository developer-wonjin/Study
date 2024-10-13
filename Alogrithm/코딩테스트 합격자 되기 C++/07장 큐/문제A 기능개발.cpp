#include <string>
#include <vector>
#include <queue>

using namespace std;

/*
각 기능은 진도가 100% => 서비스반영

각 기능의 개발속도는 모두 다름.
뒤에 있는 기능이 앞에 있는 기능보다 먼저 개발될 수 있고,
뒤에 있는 기능은 앞에 있는 기능이 배포될 때 함께 배포됩니다.

먼저 배포되어야 하는 순서대로 작업의 진도가 적힌 정수 배열 progresses와
각 작업의 개발 속도가 적힌 정수 배열 speeds가 주어질 때 
각 배포마다 몇 개의 기능이 배포되는지를 return 하도록 solution 함수를 완성하세요.
*/
vector<int> solution(vector<int> progresses, vector<int> speeds) {
    vector<int> answer;
    
    queue<int> q;
    
    for (int i = 0; i < progresses.size(); i++)q.push(i);
    
    int t = 0;
    while(q.size()){
        t++;
        for (int i = 0; i < progresses.size(); i++) {
            progresses[i] += speeds[i];
        }
        
        int cnt = 0;
        while(q.size() && progresses[q.front()] >= 100) {
            q.pop();
            cnt++;
        }
        if (cnt) answer.push_back(cnt);
    }
    
    return answer;
}