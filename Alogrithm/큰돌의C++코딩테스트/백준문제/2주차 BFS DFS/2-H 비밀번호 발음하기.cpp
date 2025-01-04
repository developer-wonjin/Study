// https://www.acmicpc.net/problem/4659

#include<bits/stdc++.h>

using namespace std;
/*




입력
입력은 여러개의 테스트 케이스로 이루어져 있다.

각 테스트 케이스는 한 줄로 이루어져 있으며, 각 줄에 테스트할 패스워드가 주어진다.

마지막 테스트 케이스는 end이며, 패스워드는 한글자 이상 20글자 이하의 문자열이다.

또한 패스워드는 대문자를 포함하지 않는다.

출력
각 테스트 케이스를 '예제 출력'의 형태에 기반하여 품질을 평가하여라.

예제 입력 1 
a
tv
ptoui
bontres
zoggax
wiinq
eep
houctuh
end

예제 출력 1 
<a> is acceptable.
<tv> is not acceptable.
<ptoui> is not acceptable.
<bontres> is not acceptable.
<zoggax> is not acceptable.
<wiinq> is not acceptable.
<eep> is acceptable.
<houctuh> is acceptable.
*/
bool isMo(char &ch) {
    return ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u';
}
bool isContainMoum(string &str) {
    for(auto& ch : str) {
        return isMo(ch);
    }
    return false;
}

bool isSequtial(string &str) {
    int ja = 0, mo = 0;
    for(auto& ch : str) {
        if (isMo(ch)) {

        } else {

        }
    }
}

int main() {

    ios::sync_with_stdio(0); cin.tie(0);

    string word;
    while (cin >> word) {
        if (word == "end") break;
        /*
        모음(a,e,i,o,u) 하나를 반드시 포함하여야 한다.
        모음이 3개 혹은 자음이 3개 연속으로 오면 안 된다.
        같은 글자가 연속적으로 두번 오면 안되나, ee 와 oo는 허용한다.
        */


    }

    return 0;
}