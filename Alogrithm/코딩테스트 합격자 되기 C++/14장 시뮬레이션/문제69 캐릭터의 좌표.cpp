// https://school.programmers.co.kr/learn/courses/30/lessons/120861
#include<bits/stdc++.h>

using namespace std;

map<string, vector<int>> dxdy = {
    {"up",   {0, 1}},
    {"down", {0, -1}},
    {"left", {-1, 0}},
    {"right",{1, 0}}
};
vector<int> solution(vector<string> keyinputs, vector<int> board) {

    int xSize = board[0];
    int ySize = board[1];

    int currX = xSize / 2;
    int currY = ySize / 2;

    for (auto& keyinput : keyinputs) {
        int nx = currX + dxdy[keyinput][0];
        int ny = currY + dxdy[keyinput][1];

        if (nx < 0 || nx >= xSize || ny < 0 || ny >= ySize) continue;
        currX = nx;
        currY = ny;

        cout << currX - xSize / 2 << ", " << currY - ySize / 2 << "\n";
    }

    return {currX - xSize / 2, currY - ySize / 2};
}

int main() {

    ios::sync_with_stdio(0); cin.tie(0);

    return 0;
}

/*
문제 설명
게임에는 up, down, left, right 방향키가 있으며 
각 키를 누르면 위, 아래, 왼쪽, 오른쪽으로 한 칸씩 이동합니다. 

예를 들어 [0,0]에서 
up을 누른다면 캐릭터의 좌표는 [0, 1], 
down을 누른다면 [0, -1], 
left를 누른다면 [-1, 0], 
right를 누른다면 [1, 0]입니다. 

머쓱이가 입력한 방향키의 배열 keyinput와 맵의 크기 board이 매개변수로 주어집니다. 
캐릭터는 항상 [0,0]에서 시작할 때 키 입력이 모두 끝난 뒤에 캐릭터의 좌표 [x, y]를 return하도록 solution 함수를 완성해주세요.

[0, 0]은 board의 정 중앙에 위치합니다. 
예를 들어 board의 가로 크기가 9라면 캐릭터는 왼쪽으로 최대 [-4, 0]까지 
오른쪽으로 최대 [4, 0]까지 이동할 수 있습니다.

제한사항
board은 [가로 크기, 세로 크기] 형태로 주어집니다.
board의 가로 크기와 세로 크기는 홀수입니다.
board의 크기를 벗어난 방향키 입력은 무시합니다.
0 ≤ keyinput의 길이 ≤ 50
1 ≤ board[0] ≤ 99
1 ≤ board[1] ≤ 99
keyinput은 항상 up, down, left, right만 주어집니다.

입출력 예
keyinput	board	result
["left", "right", "up", "right", "right"]	[11, 11]	[2, 1]
["down", "down", "down", "down", "down"]	[7, 9]	[0, -4]
입출력 예 설명
입출력 예 설명 #1

[0, 0]에서 왼쪽으로 한 칸 오른쪽으로 한 칸 위로 한 칸 오른쪽으로 두 칸 이동한 좌표는 [2, 1]입니다.
입출력 예 설명 #2

[0, 0]에서 아래로 다섯 칸 이동한 좌표는 [0, -5]이지만 맵의 세로 크기가 9이므로 아래로는 네 칸을 넘어서 이동할 수 없습니다. 따라서 [0, -4]를 return합니다.
*/