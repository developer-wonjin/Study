#include<bits/stdc++.h>

using namespace std;

int sol(){
    int a[5] = {1,2,3,4,5};
    int sum = 0;
    for (auto ele : a)sum += ele;
    return sum;
}

int sol2(){
    int a[5] = {1,2,3,4,5};

    return accumulate(a, a+5, 0);
}

int main(){
    ios::sync_with_stdio(0); cin.tie(0);

    return 0;
}