//https://school.programmers.co.kr/learn/courses/30/lessons/120817
#include <string>
#include <vector>
#include <numeric>

using namespace std;

double solution(vector<int> numbers) {
/*
    정수 배열 numbers가 매개변수로 주어집니다. 
    numbers의 원소의 평균값을 return하도록 solution 함수를 완성해주세요.
*/
    return accumulate(numbers.begin(), numbers.end(), 0.0) / numbers.size();
}