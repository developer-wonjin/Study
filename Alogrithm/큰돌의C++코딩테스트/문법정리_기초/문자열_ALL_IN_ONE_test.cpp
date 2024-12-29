#include<bits/stdc++.h>

using namespace std;

vector<string> split(string str, string delimeter) {

    vector<string> ret;

    int s = 0;
    int e = str.find(delimeter);

    while (e != string::npos) {
        ret.push_back(str.substr(s, e - s));

        s = e + delimeter.size();
        e = str.find(delimeter, s);
    }
    ret.push_back(str.substr(s));

    return ret;
}

int main() {

    vector<string> splits = split("ABC=>DEF=>GH", "=>");
    for (auto &ele : splits) cout << ele << " ";
    cout << "\n";

    // string(size, value);
    string str3(5, 'A');
    cout << str3 << "\n";

    // string(str);
    string str = "ABCDE";
    string str1(str);
    cout << str1 << "\n";

    // string(str, sIdx, size)
    string str2(str, 1, 3);
    cout << str2 << "\n";

    // +=
    string str4 = str1 + "FG";
    cout << str4 << "\n";


    // insert
    string str5 = "AAAA";
    str5.insert(2, "KKK");
    cout << str5 << "\n";

    // remove => erase
    string str6 = "ABCD    E F";
    auto it = remove(str6.begin(), str6.end(), ' ');
    cout << str6 << "\n";
    str6.erase(it, str6.end());
    cout << str6 << "\n";


    string str7 = "ABCDEF";

    // find 첫위치부터
    auto idx = str7.find("CD");
    cout << idx << "\n";

    // find i위치부터
    idx = str7.find("CD", 2);
    cout << "find i위치부터: " << idx << "\n";

    // find i위치부터
    idx = str7.find("CD", 3);
    if (idx == string::npos) {
        cout << "find i위치부터: None" << "\n";
    }

    // find
    string str8 = "ABCDEF";
    idx = str8.find("a");
    if (idx == string::npos) {
        cout << "None" << "\n";
    }
    
    // substr
    string str9 = "ABCDE";
    cout << str9.substr(1, 3) << "\n";//BCD

    // pop_back
    string str10 = "ABCDE";
    str10.pop_back();
    cout << str10 << "\n";//ABCD

    // to_string
    string str12 = to_string(123);
    cout << str12 << "\n";

    // atoi
    int n1 = atoi("123");
    int n2 = atoi("0");
    int n3 = atoi("a");

    cout << "n1: " << n1 << "\n";
    cout << "n2: " << n2 << "\n";
    cout << "n3: " << n3 << "\n";

    // stoi
    n1 = stoi("123");
    n2 = stoi("0");
    cout << "n1: " << n1 << "\n";
    cout << "n2: " << n2 << "\n";

    // n3 = stoi("a");
    // cout << "n3: " << n3 << "\n";

    // replace
    string str13 = "01234567890";
    string target = "AAAA";
    str13.replace(2, target.size(), target);
    cout << "str13: " << str13 << "\n\n";

    return 0;
}