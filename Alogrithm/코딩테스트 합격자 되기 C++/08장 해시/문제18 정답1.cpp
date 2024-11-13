//https://www.acmicpc.net/problem/3273
//일곱난쟁이

/*
문제
n개의 서로 다른 양의 정수 a1, a2, ..., an으로 이루어진 수열이 있다. 
ai의 값은 1보다 크거나 같고, 1000000보다 작거나 같은 자연수이다. 
자연수 x가 주어졌을 때, ai + aj = x (1 ≤ i < j ≤ n)을 만족하는 
(ai, aj)쌍의 수를 구하는 프로그램을 작성하시오.

입력
첫째 줄에 수열의 크기 n이 주어진다. 
다음 줄에는 수열에 포함되는 수가 주어진다. 
셋째 줄에는 x가 주어진다. (1 ≤ n ≤ 100,000, 1 ≤ x ≤ 2,000,000)

출력
문제의 조건을 만족하는 쌍의 개수를 출력한다.

9
5 12 7 10 9 1 2 3 11
13

3
*/
#include<bits/stdc++.h>

using namespace std;

int input;
int n, x;
vector<int> v;
int check[2000001];
int res;
// 128MB = 128_000_000 byte = 4byte * 32000000 개
int main(){

    ios::sync_with_stdio(0); cin.tie(0);

    cin >> n;

    for (int i = 0; i < n; i++){
        int temp;
        cin >> temp;
        v.push_back(temp);
    }
    cin >> x;


    /*[정답패턴]
    다음 두 줄은 반드시 선후관계를 뒤집으면 안된다.
    ex. 두 수의 합 x = 8 일 때 ele = 4 이면 res에 카운트가 되면 안된다.*/
    for (int ele : v) {
        int target = x - ele;

        // 배열을 위한 처리
        if (target <= 0) continue;
        if (check[target]) res++;
        check[ele] = 1;

    }

    cout << res;
    return 0;
}