#include<bits/stdc++.h>
using namespace std;

int main()
{
    ios::sync_with_stdio(0); cin.tie(0);

    //입력 데이터가 4개면 +1한 배열을 만들어준다.
    int nums[5] = {0, 20, 30, 40, 50};

    int psum[5] = {};

    for (int i = 1; i < 1 + 4; i++){
        psum[i] = psum[i-1] + nums[i];
    }

    for (auto ele : psum) cout << ele << " ";

    return 0;
}