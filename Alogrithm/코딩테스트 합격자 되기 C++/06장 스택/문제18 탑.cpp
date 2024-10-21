//https://www.acmicpc.net/problem/2493

#include<bits/stdc++.h>

using namespace std;

/*
일직선 위에 N개의 '높이가 서로 다른' 탑을 수평 직선의 왼쪽부터 오른쪽 방향으로 차례로 세우고,
각 탑의 꼭대기에 레이저 송신기를 설치
모든 탑의 레이저 송신기는 레이저 신호를 '지표면과 평행하게' 수평 직선의 '왼쪽 방향'으로 발사, 
탑의 기둥 모두에는 레이저 신호를 수신하는 장치가 설치되어 있다. 

하나의 탑에서 발사된 레이저 신호는 '가장 먼저' 만나는 단 하나의 탑에서만 수신이 가능하다.

예를 들어 
높이가 6, 9, 5, 7, 4인 다섯 개의 탑이 수평 직선에 일렬로 서 있고, 
모든 탑에서는 주어진 탑 순서의 반대 방향(왼쪽 방향)으로 동시에 레이저 신호를 발사한다고 하자. 
그러면, 
높이가 4인 다섯 번째 탑에서 발사한 레이저 신호는 높이가 7인 네 번째 탑이 수신을 하고, 
높이가 7인 네   번째 탑의 신호는 높이가 9인 두 번째 탑이, 
높이가 5인 세   번째 탑의 신호도 높이가 9인 두 번째 탑이 수신을 한다. 
높이가 9인 두 번째 탑과 높이가 6인 첫 번째 탑이 보낸 레이저 신호는 어떤 탑에서도 수신을 하지 못한다.

탑들의 개수 N과 탑들의 높이가 주어질 때, 
각각의 탑에서 발사한 레이저 신호를 어느 탑에서 수신하는지를 알아내는 프로그램을 작성하라.
*/

int N;
int height[500005];
int receive[500005];
stack<int> stk;
int main(){
    ios::sync_with_stdio(0); cin.tie(0);

    /*첫째 줄에 탑의 수를 나타내는 정수 N이 주어진다. 
    N은 1 이상 500,000 이하이다.
    둘째 줄에는 N개의 탑들의 높이가 직선상에 놓인 순서대로 하나의 빈칸을 사이에 두고 주어진다.
    탑들의 높이는 1 이상 100,000,000 이하의 정수이다.
    */

    cin >> N;
    for (int i = 0; i < N; i++) cin >> height[i];

    for (int i = N-1; i >= 0; i--){
        while(stk.size() && height[i] >= height[stk.top()]) {
            int tIdx = stk.top(); stk.pop();
            receive[tIdx] = i + 1;
            // cout << "pop: " << tIdx << "\n";
        }

        // cout << "push: " << i << "\n";
        stk.push(i);
    }

    while (stk.size()) {
        int tIdx = stk.top(); stk.pop();
        // cout << "pop: " << tIdx << "\n";
        receive[tIdx] = 0;
    }

    for (int i = 0; i < N; i++){
        cout << receive[i] << " ";
    }

    return 0;
}