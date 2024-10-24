// https://school.programmers.co.kr/learn/courses/30/lessons/42577

#include <string>
#include <vector>
#include <unordered_map>

using namespace std;

unordered_map<string, int> phoneBook;

bool isPrefix (string& phoneNumber) {
    string prefix = "";
    for (char digit : phoneNumber) {
        prefix += digit;
        if (phoneBook.find(prefix) != phoneBook.end() && prefix != phoneNumber) {
            return true;
        }
    }
    return false;
}

bool solution(vector<string> phoneNumbers) {

    for (string& phoneNumber : phoneNumbers) {
        phoneBook[phoneNumber] = 1;
    }

    for (string& phoneNumber : phoneNumbers) {
        if (isPrefix(phoneNumber)) return false;
    }
    return true;
}