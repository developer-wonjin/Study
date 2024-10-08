#include<iostream>
#include<vector>
#include<map>
#include<algorithm>
#include<ctime>
#include<iomanip>

using namespace std;

void bubbleSort(vector<int>& v){
    int n = (int)v.size();
    for(int i = 0; i < n - 1; i++){
        for (int j = 0; j < n - 1 - i; j++){
            if (v[j] > v[j+1]) swap(v[j], v[j+1]);
        }
    }
}

int main() {
    int sizes[] = {10, 100, 1000, 10000, 100000};
    map<int, string> m = {
        {10, ""},
        {100, ""},
        {1000, ""},
        {10000, "1만"},
        {20000, "2만"},
        {30000, "3만"},
        {40000, "4만"},
        {50000, "5만"},
        {60000, "6만"},
        {70000, "7만"},
        {80000, "8만"},
        {90000, "9만"},
        {100000, "10만"}
    };

    for (auto& p : m) {
        int size = p.first;
        string desc = p.second;

        vector<int> v(size);
        for (int i = 0; i < size; i++) v[i] = size - i;

        clock_t startQuick = clock();
        bubbleSort(v);
        clock_t endQuick = clock();
        double timeQuick = double(endQuick - startQuick)/CLOCKS_PER_SEC;

        cout << "버블정렬시간 (N=" << setw(6) << size << ", " << desc << "): " 
           << fixed << setprecision(3) << timeQuick <<  " 초" << "\n";
    }
    /*
    버블정렬시간 (N=    10, ): 0.000 초
    버블정렬시간 (N=   100, ): 0.000 초
    버블정렬시간 (N=  1000, ): 0.009 초
    버블정렬시간 (N= 10000, 1만): 1.031 초 ==> 1E4 만 넘어가도 1초를 넘겨버림
    버블정렬시간 (N= 20000, 2만): 3.799 초
    */
}