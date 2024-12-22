#include <string>
#include <vector>

using namespace std;

vector<int> solution(int brown, int yellow) {
    
    for (int y = 1; y <= brown + yellow; y++) {
        if ((brown + yellow) % y) continue;
        
        int x = (brown + yellow) / y;
        
        if (y + x == (brown + 4) / 2) return {x, y};
    }
    
    return {};
}