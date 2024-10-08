#include<bits/stdc++.h>

using namespace std;

set<int> s;

// 내부적으로 정렬됨(균형이진트리)
set<int> s1 = {5, 4, 3, 2, 1};

set<int> s2(s1);


int main (){
    for (auto& ele : s1) cout << ele << " ";// 1 2 3 4 5 정렬순으로 출력됨

    auto it = s1.find(7);
    if (it == s1.end())cout << "요소 없음" << "\n";
    else cout << "요소 찾음\n";

    s1.insert(100);
    
    // 삭제 방식 2가지
    s1.erase(6);

    auto it2 = s1.find(5);
    if (it2 != s1.end()){
        s1.erase(it2);
    }

    s1.erase(4);

    for (auto& ele : s1)cout << ele << " ";
}