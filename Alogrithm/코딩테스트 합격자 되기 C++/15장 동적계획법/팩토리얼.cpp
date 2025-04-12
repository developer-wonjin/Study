#include<bits/stdc++.h>

using namespace std;

long long factorial(long long n) {

    cout << "factorial(" << n << ")" << "\n";

    if (n == 1) return 1;
    
    return factorial(n-1) * n;

}

int main() {

    ios::sync_with_stdio(0); cin.tie(0);

    long long n;
    cin >> n;

    cout << factorial(n) << "\n";

    return 0;
}