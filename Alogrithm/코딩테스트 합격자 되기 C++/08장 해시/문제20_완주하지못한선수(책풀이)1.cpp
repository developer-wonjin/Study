#include <string>
#include <vector>
#include <algorithm>

using namespace std;

string solution(vector<string> participant, vector<string> completion) {

    sort(participant.begin(), participant.end());
    sort(completion.begin(), completion.end());
    
    for(int i=0;i<completion.size();i++)
    {
        if(participant[i] != completion[i])
            return participant[i];
    }

    // A B C D E F (참여)
    // A B D E F   (완주)

    // 0 1 2 3 4 5
    // A B C D E F
    // A B C D E  
    return participant[participant.size() - 1];
}



//아래 코드는 테스트 코드 입니다.

#include <iostream>

int main()
{
    cout << solution({"leo", "kiki", "eden"}, {"eden", "kiki"}) << endl; // "leo"
    cout << solution({"marina", "josipa", "nikola", "vinko", "filipa"}, {"josipa", "filipa", "marina", "nikola"}) << endl; // "vinko"
    cout << solution({"mislav", "stanko", "mislav", "ana"}, {"stanko", "ana", "mislav"}) << endl; // "mislav"
    return 0;

}