#include<bits/stdc++.h>

using namespace std;

void solution1() {
    int a;
    
    for (int i = 0; i < 3; i++){
        int cnt[2] = {};
        for (int j = 0; j < 4; j++) {
            cin >> a;
            if (a == 0) cnt[0]++;
            else cnt[1]++;
        }

        switch (cnt[0]) {
            case 1:
                cout << "A\n";
                break;
            case 2:
                cout << "B\n";
                break;
            case 3:
                cout << "C\n";
                break;
            case 4:
                cout << "D\n";
                break;
            case 0:
                cout << "E\n";
                break;
        }
    }

}

int main() {
    ios::sync_with_stdio(0); cin.tie(0);

    solution1();

    return 0;
}