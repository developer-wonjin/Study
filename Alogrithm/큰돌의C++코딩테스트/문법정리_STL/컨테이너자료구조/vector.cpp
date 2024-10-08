#include<bits/stdc++.h>
using namespace std;

// {} 크기없음
vector<int> v1;



// {0, 0}
vector<int> v1(2);
/*
{{0, 0, 0, 0, 0} 
,{0, 0, 0, 0, 0}}*/
vector<vector<int>> v1(2, vector<int>(5));




// {100, 100}
vector<int> v2(2, 100);
/*
{{100, 100, 100, 100, 100} 
,{100, 100, 100, 100, 100}}*/
vector<vector<int>> v2(2, vector<int>(5, 100));

vector<vector<int>> v2 = {{100, 100, 100, 100, 100} 
                         ,{100, 100, 100, 100, 100}};



// 복사
vector<int> v3(v1);
vector<int> v3(v1.rbegin(), v1.rend()); //역순