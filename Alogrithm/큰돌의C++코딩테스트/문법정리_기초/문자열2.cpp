#include<bits/stdc++.h>

using namespace std;

int main(){
    ios::sync_with_stdio(0); cin.tie(0);

    string a = "love is";
    a += " pain!";
    a.pop_back();
    cout << a << " : " << a.size() << "\n";
    cout << char(* a.begin()) << '\n';
    cout << char(* (a.end()-1)) << '\n';
    
    // 삽입하기
    // string& insert (size_t pos, const string& str);
    a.insert(0, "test ");
    cout << a << " : " << a.size() << "\n";
    
    // 지우기
    // string& erase (size_t pos = 0, size_t len = npos);
    a.erase(0, 5);
    cout << a << " : " << a.size() << "\n";

    // 대체하기
    a.replace(2, 3, "wonjin");
    cout << a << "\n";
    
    // 찾기, 포함여부
    // size_t find (const string& str, size_t pos = 0);
    auto it = a.find("love");
    if (it != string::npos){
        cout << "포함되어있다." << '\n';
    }
    cout << it << '\n';
    cout << string::npos << '\n';
    
    // 문자열자르기
    // string substr (size_t pos = 0, size_t len = npos) const;
    cout << a.substr(5, 2) << '\n';

    return 0;
}