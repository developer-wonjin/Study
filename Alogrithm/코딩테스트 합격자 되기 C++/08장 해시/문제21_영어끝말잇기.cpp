//https://school.programmers.co.kr/learn/courses/30/lessons/12981
#include <string>
#include <vector>
#include <unordered_set>

using namespace std;
/*
끝말잇기에 참여하는 사람의 수 n은 2 이상 10 이하의 자연수입니다.
words는 끝말잇기에 사용한 단어들이 순서대로 들어있는 배열이며, 길이는 n 이상 100 이하입니다.
단어의 길이는 2 이상 50 이하입니다.
모든 단어는 알파벳 소문자로만 이루어져 있습니다.
끝말잇기에 사용되는 단어의 뜻(의미)은 신경 쓰지 않으셔도 됩니다.
정답은 [ 번호, 차례 ] 형태로 return 해주세요.
만약 주어진 단어들로 탈락자가 생기지 않는다면, [0, 0]을 return 해주세요.
*/
unordered_set<string> uset;
vector<int> solution(int n, vector<string> words) {
    
    uset.insert(words[0]);

    // i = 0 부터 시작하면 안에 for문로직이 지저분해질 것임
    for (int i = 1; i < words.size(); i++) {
        string currWord = words[i];
        string beforeWord = words[i-1];

        // 등장한적 있는 단어 이거나 시작이 다른 단어
        if (uset.find(currWord) != uset.end() 
            ||beforeWord[beforeWord.size() - 1] != currWord[0]) {
            int assignedNum = (i % n) + 1;
            int th = (i / n) + 1;
            return {assignedNum, th};
        }  

        // 등장한적 없는 단어 등록
        uset.insert(currWord);
    }
    return {0, 0};
}