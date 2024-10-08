//https://school.programmers.co.kr/learn/courses/30/lessons/49994
#include <string>
using namespace std;

int dy[] = {-1, 0, 1, 0};
int dx[] = {0, 1, 0, -1};
bool visited[11][11][4];

int toDir(char dir){
    int returnDir;
    if(dir == 'U')returnDir = 0;
    else if(dir == 'R')returnDir = 1;
    else if(dir == 'D')returnDir = 2;
    else returnDir = 3;
    return returnDir;
}

bool isNotValid(int posY, int posX){
    return posY < 0 || posY >= 11 || posX < 0 || posX >= 11;
}

int opposite_direction(int dir) {
    return (dir + 2) % 4;
}

int solution(string dirs) {
    int answer = 0;
    int y = 5, x = 5;

    for (auto c : dirs) {
        int dir = toDir(c);
        int ny = y + dy[dir];
        int nx = x + dx[dir];
        if (isNotValid(ny, nx))continue;

        // 현위치에서 dir방향으로 이동한 적이 없다면
        // 이동기록을 남기고 카운트+1한다
        if (visited[y][x][dir] == false) {
            visited[y][x][dir] = true;
            visited[ny][nx][opposite_direction(dir)] = true;
            answer++;
        }

        y = ny;
        x = nx;

    }

    return answer;
}