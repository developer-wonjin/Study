// https://school.programmers.co.kr/learn/courses/30/lessons/12985
#include <iostream>

using namespace std;

int solution(int n, int a, int b)
{
    int answer = 0;

    while (a != b) {
        answer++;
        a = (a+1)/2;
        b = (b+1)/2;
    } 

    return answer;
}

int main() {
    cout << solution(8, 1, 2) << "\n";
    cout << solution(8, 1, 3) << "\n";
    cout << solution(8, 1, 4) << "\n";
    cout << solution(8, 1, 5) << "\n";
    cout << solution(8, 1, 6) << "\n";
    cout << solution(8, 1, 7) << "\n";
    cout << solution(8, 1, 8) << "\n";
    cout << solution(8, 4, 7) << "\n";
    return 0;
}