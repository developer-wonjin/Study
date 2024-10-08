//https://school.programmers.co.kr/learn/courses/30/lessons/49994

#include <string>
#include <set>

using namespace std;

int solution(string dirs) {
    int answer = 0;

    // dirs는 string형으로 주어지며, 'U', 'D', 'R', 'L' 이외에 문자는 주어지지 않습니다.
    // dirs의 길이는 500 이하의 자연수입니다.

    /*
    게임 캐릭터를 4가지 명령어를 통해 움직이려 합니다. 명령어는 다음과 같습니다.
    U: 위쪽으로 한 칸 가기
    D: 아래쪽으로 한 칸 가기
    R: 오른쪽으로 한 칸 가기
    L: 왼쪽으로 한 칸 가기
    
    캐릭터는 좌표평면의 (0, 0) 위치에서 시작합니다. 
    좌표평면의 경계는 왼쪽 위(-5, 5), 왼쪽 아래(-5, -5), 오른쪽 위(5, 5), 오른쪽 아래(5, -5)
    */

    // 캐릭터가 처음 걸어본 길의 길이
    // 좌표평면의 경계를 넘어가는 명령어는 무시합니다.

    int y = 0, x = 0;

    // 아이디어 (동선에 관한 from, to set을 도입한다)
    set<pair<pair<int, int>, pair<int, int>>> mySet;

    for (char& dir : dirs){
        int dy=0, dx=0;
        if (dir == 'U'){
            dy = -1;
        } else if (dir == 'D'){
            dy = 1;
        } else if (dir == 'R'){
            dx = 1;
        } else {
            dx = -1;
        }

        if (y + dy < -5 || y + dy > 5) continue;
        if (x + dx < -5 || x + dx > 5) continue;

        auto it = mySet.find({{y, x}, {y + dy, x + dx}});
        if (it == mySet.end()){
            mySet.insert({{y, x}, {y + dy, x + dx}});
            mySet.insert({{y + dy, x + dx}, {y, x}});
            answer++;
        }

        y += dy;
        x += dx;
    }

    return answer;
}