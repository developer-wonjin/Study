#include <vector>
#include <iterator>
#include <iostream>

using namespace std;

vector<int> v;

int n = 5;

void printV() {
  for (auto& ele : v) cout << ele << " ";
  cout << "\n";
}

void DFS(int start, int sum) {
  cout << "start: " << start << ", sum: " << sum << " | ";
  printV();
  if (sum == 10) {
    cout << " => 만족\n";
    return;
  }
  if (sum > 10) {
    cout << "초과했기에 가능성 없음\n";
    return;
  }

  for (int i = start; i <= n; i++) {
    v.push_back(i);
    DFS(i + 1, sum + i);
    v.pop_back();
  }
}

int main() {

  ios::sync_with_stdio(0); cin.tie(0);

  DFS(1, 0);

  return 0;
}