#include<iostream>
#include<vector>
#include<algorithm>
#include<ctime>

using namespace std;

int main() {
    int sizes[] = {10, 100, 1000, 10000, 100000, 1000000, 10000000};

    for (int size : sizes) {
        vector<int> v(size);
        for (int i = 0; i < size; i++) v[i] = size - i;
        clock_t startQuick = clock();
        sort(v.begin(), v.end());
        clock_t endQuick = clock();
        double timeQuick = double(endQuick - startQuick)/CLOCKS_PER_SEC;

        cout << "퀵   정렬시간: " << timeQuick <<  " 초" << "\n";
    }
}