//https://www.acmicpc.net/problem/13300
#include<bits/stdc++.h>

using namespace std;

int N, K;
int S, Y;

int school[7][2];

int main (){

    ios::sync_with_stdio(0); cin.tie(0);

    /*
    첫 번째 줄에는 수학여행에 참가하는 학생 수를 나타내는 정수 N(1 ≤ N ≤ 1,000)과 
    한 방에 배정할 수 있는 최대 인원 수 K(1 < K ≤ 1,000)가 공백으로 분리되어 주어진다. 
    
    다음 N 개의 각 줄에는 학생의 성별 S와 학년 Y(1 ≤ Y ≤ 6)가 공백으로 분리되어 주어진다.
    성별 S는 0, 1중 하나로서 
    여학생인 경우에 0, 
    남학생인 경우에 1로 나타낸다. 
    */

    cin >> N >> K;

    for (int i = 0; i < N; i++){
        cin >> S >> Y;
        school[Y][S]++;
    }

    int tot = 0;
    for (int y = 1; y < 7; y++){
        for (int s = 0; s < 2; s++){
            //방법1
            //tot += ceil(school[y][s] / (double)K);

            //방법2
            tot += school[y][s] / K;
            if (school[y][s] % K)tot++;
        }
    }

    cout << tot;

    /*
    2박 3일
    1학년부터 6학년까지 학생들이 묵을 방을 배정해야 한다. 
    남학생은 남학생끼리, 
    여학생은 여학생끼리 방을 배정
    한 방에는 같은 학년의 학생들을 배정
    (한 방에 한 명만 배정하는 것도 가능)

    한 방에 배정할 수 있는 최대 인원 수 K가 주어졌을 때,
    조건에 맞게 모든 학생을 배정하기 위해 필요한 방의 최소 개수를 구하는 프로그램을 작성하시오.

    예를 들어, 
    K = 2일 때 12개의 방이 필요하다. 
    왜냐하면 
    3학년 남학생을 배정하기 위해 방 두 개가 필요하고 
    4학년 여학생에는 방을 배정하지 않아도 되기 때문이다.
    
    */

    return 0;
}