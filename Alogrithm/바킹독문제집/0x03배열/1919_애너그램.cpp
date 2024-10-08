//https://www.acmicpc.net/problem/1919

#include<bits/stdc++.h>

using namespace std;

string str1, str2;
const int LMAX = 'z' - 'a' + 1;
int check[LMAX];

int main(){
    ios::sync_with_stdio(0); cin.tie(0);



    /*
    첫째 줄과 둘째 줄에 영어 단어가 소문자로 주어진다. 
    각각의 길이는 1,000자를 넘지 않으며, 
    적어도 한 글자로 이루어진 단어가 주어진다.
    */

    cin >> str1 >> str2;
    
    for (auto c : str1){
        check[c - 'a']++;
    }

    for (auto c : str2){
        check[c - 'a']--;
    }

    int tot = 0;
    for (auto ele : check) tot += abs(ele);

    cout << tot;

    return 0;
}