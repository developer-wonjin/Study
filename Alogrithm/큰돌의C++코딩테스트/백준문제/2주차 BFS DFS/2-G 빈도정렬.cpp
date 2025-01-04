// https://www.acmicpc.net/problem/2910
#include<bits/stdc++.h>

using namespace std;

/*
문제
위대한 해커 창영이는 모든 암호를 깨는 방법을 발견했다. 
그 방법은 빈도를 조사하는 것이다.

창영이는 말할 수 없는 방법을 이용해서 현우가 강산이에게 보내는 메시지를 획득했다. 

이 메시지는 숫자 N개로 이루어진 수열이고, 
숫자는 모두 C보다 작거나 같다. 
창영이는 이 숫자를 자주 등장하는 빈도순대로 정렬하려고 한다.

예제 입력 1 
5 2
2 1 2 1 2
예제 출력 1 
2 2 2 1 1
예제 입력 2 
9 3
1 3 3 3 2 2 2 1 1
예제 출력 2 
1 1 1 3 3 3 2 2 2
예제 입력 3 
9 77
11 33 11 77 54 11 25 25 33
예제 출력 3 
11 11 11 33 33 25 25 77 54
*/

unordered_map<int, int> freq;        // 출현빈도를 저장
unordered_map<int, int> firstPresent;// 최초 출현한 순번을 저장
int N, C;
vector<int> arr;

/*
만약, 수열의 두 수 X와 Y가 있을 때, 
X가 Y보다 수열에서 많이 등장하는 경우 ==> X가 Y보다 앞에 있어야 한다. 
등장하는 횟수가 같다면 ==> 먼저 나온 것이 앞에 있어야 한다.
*/
bool cmp (int &a, int &b) {
    if (freq[a] == freq[b]) return firstPresent[a] < firstPresent[b];
    return freq[a] > freq[b];
}

int main() {
    // 128MByte = 128 * 1000 * 1000 byte = 128,000,000 byte
    ios::sync_with_stdio(0); cin.tie(0);
/*
입력
첫째 줄에 메시지의 길이 N과 C가 주어진다. (1 ≤ N ≤ 1,000, 1 ≤ C ≤ 1,000,000,000)
둘째 줄에 메시지 수열이 주어진다.

출력
첫째 줄에 입력으로 주어진 수열을 빈도 정렬한 다음 출력한다.
*/
    cin >> N >> C;

    int temp;
    for (int i = 0; i < N; i++) {
        cin >> temp;

        if (freq.find(temp) == freq.end()) firstPresent[temp] = i;

        freq[temp]++;
        arr.push_back(temp);
    }

    sort(arr.begin(), arr.end(), cmp);

    for (auto& ele : arr) cout << ele << " ";

    return 0;
}

