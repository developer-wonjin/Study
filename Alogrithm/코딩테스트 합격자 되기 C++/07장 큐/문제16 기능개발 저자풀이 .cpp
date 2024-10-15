#include <string>
#include <vector>
#include <queue>
#include <iostream>
#include <cmath>
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
    int n = progresses.size();
    vector<int> days_left(n);
    
    int operCnt = 0;
    for (int i = 0; i < n; i++){
        operCnt++;
        days_left[i] = ceil((100.0 - progresses[i]) / speeds[i]);
    }

    int count = 0;
    int max_day = days_left[0];

    for(int i = 0; i < n; i++){
        operCnt++;
        if(days_left[i] <= max_day){
            count++;
        }else {
            answer.push_back(count);
            count = 1;
            max_day = days_left[i];
        }
    }

    answer.push_back(count);
    cout << operCnt << "\n";
    return answer;
}

int main(){

    solution({93, 30, 55}, {1, 30, 5});
    solution({95, 90, 99, 99, 80, 99}, {1, 1, 1, 1, 1, 1});

    return 0;
}