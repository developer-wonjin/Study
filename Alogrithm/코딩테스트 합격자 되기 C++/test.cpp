#include <iostream>
#include <string>
#include <stack>
#include <vector>
using namespace std;

int main(void) {

    vector<int> a = {1,2,3,4,5,6};

    for (auto it = a.rbegin(); it != a.rend(); it++) {
        cout << *it << " ";
    }

    return 0;
}