#include<bits/stdc++.h>

using namespace std;

int main() {
    // cin, cout은 입출력 시간초과를 막기위해 아래 명령을 실행시켜야함
    // 입출력이 많을 때 시간초과나지 않게 막아줌
    // cstream과 c++stream을 동기화시키는 작업을 없애줌
    // 따라서 cin, cout 을 printf, scanf와 섞어 사용하면 안됨!!
    ios::sync_with_stdio(0); 
    
    // 
    cin.tie(NULL); cout.tie(NULL);


    // [cin으로 입력 받을 때]
    // 1. 띄어쓰기, 엔터를 만나면 그 전까지 입력했던 값이 변수에 할당된다.
    // 2. cin은 타입을 가리지 않고 모두 적절하게 값을 할당해줌
    // int a1; string a2;
    // cin >> a1 >> a2; 
    // cout << a1 << ", " << a2;

    // [getline(cin, string, endDelimeter)사용법]
    // 1. 입력행을 통째로 문자열로 받음
    // 2. 종결문자를 지정가능
    // 3. (주의!) cin >> 변수; 를 사용후 getline을 사용할 경우 개행제거작업해줘야함
    // string s;
    // getline(cin, s, ',');
    // cout << s << "\n";
    /*
    hello my name is,
    hello my name is
    */

    

    // cin 입력과 getline사이에 꼭 개행제거 코드가 있어야함
    // int T;
    // string str;
    // cin >> T;
    // string temp;
    // getline(cin, temp);

    // for (int i = 0; i < T; i++) {
    //     getline(cin, str);
    //     cout << str << "\n";
    // }

    int n;
    while (cin >> n) {
        cout << 1 << '\n';
    }
        

    return 0;
}