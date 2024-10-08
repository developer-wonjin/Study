#include<bits/stdc++.h>

using namespace std;

//first는 내림차순, second는 오름차순 정렬하고 싶다면
bool cmp(pair<int, int> a, pair<int, int> b){
    // if (a.first == b.first)
    //     return a.second < b.second;
    
    // 이 리턴문 단독으로 처리가능하다.
    // 즉, 후순위 오름차순에 대해서는 신경안써도 된다.
    return a.first > b.first;
}

 int main() {
    // pair의첫번째요소는정렬할값,두번째요소는원래인덱스를나타냄
    vector<pair<int, int>> pairs = {{5, 1}, {2, 2}, {5, 3}, {3, 4}, {2, 5}};
    cout << "Original: ";
    for (const auto& p : pairs) {
        cout << "(" << p.first << ", " << p.second << ") ";
    }
    cout << "\n";
    sort(pairs.begin(), pairs.end(), cmp);
    cout << "Sorted with sort: ";
    for (const auto& p : pairs) {
        cout << "(" << p.first << ", " << p.second << ") ";
    }
    cout << "\n";
    //원본데이터로초기화
    pairs = {{5, 1}, {2, 2}, {5, 3}, {3, 4}, {2, 5}};
    // stable_sort사용
    stable_sort(pairs.begin(), pairs.end(), cmp);
    cout << "Sorted with stable_sort: ";
    for (const auto& p : pairs) {
        cout << "(" << p.first << ", " << p.second << ") ";
    }
    cout << "\n";
    return 0;
 }
/*
Original:                  (5,1)(2,2)(5,3)(3,4)(2,5)
Sortedwithstd::sort:       (2,2)(2,5)(3,4)(5,1)(5,3)
Sortedwithstd::sort:       (2,5)(2,2)(3,4)(5,1)(5,3)
Sortedwithstd::stable_sort:(2,2)(2,5)(3,4)(5,1)(5,3)
*/
