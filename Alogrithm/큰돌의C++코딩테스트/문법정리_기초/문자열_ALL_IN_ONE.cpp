#include<bits/stdc++.h>

using namespace std;

int main() {

    // string(str);
    string con1 = "012345";
    string con2(con1);
    cout << "con2 : " << con2 << "\n";

    // string(str, s, size)
    string con3(con1, 2, 4);
    cout << "con3 : " << con3 << "\n";

    // string(size, value);
    string a5 = string(5, 'a');
    cout << "a5 : " << a5 << "\n\n";

    string str = "01234"; //길이 5
    cout << "str: " << str << " , size: " << str.size() << "\n";//str: 01234 , size: 5
    
    // +=
    str += "AA";
    cout << "str: " << str << " , size: " << str.size() << "\n";//str: 01234AA , size: 7

    // insert
    int pos = str.size() - 1;
    string target = "BBB";
    str.insert(pos, target);
    cout << "str: " << str << " , size: " << str.size() << "\n\n";//str: 01234ABBBA , size: 10  

    // remove
    string str2 = "ABC D E  F";
    cout << str2 << "\n";// ABC D E  F
    auto it = remove(str2.begin(), str2.end(), ' ');
    cout << str2 << "\n";// ABCDEFE  F
    str2.erase(it, str2.end());
    cout << str2 << "\n";// ABCDEFE

    // erase
    int sIdx = 5;
    int size = 5;
    str.erase(sIdx, size);
    cout << "str: " << str << " , size: " << str.size() << "\n\n";//str: 01234 , size: 5        

    // find
    str = "01234AAA";
    cout << "str: " << str << " , size: " << str.size() << "\n\n";//str: 01234AAA , size: 8     
    size_t it1 = str.find("AA");
    cout << it1 << "\n";       //5
    cout << str[it1] << "\n\n";//A

    // find
    size_t it2 = str.find("23", 3);
    if (it2 == string::npos) cout << "없습니다\n\n";

    // find
    size_t it3 = str.find("ZZZ");
    if (it3 == string::npos) cout << "없습니다\n\n";

    // substr
    string sub = str.substr(1, 3);
    cout << str << "\n";//01234AAA(원본유지한다)
    cout << sub << "\n\n";//123

    // pop_back
    str.pop_back();
    cout << str << "\n";//01234AA

    str[0]++;
    cout << str << "\n";//11234AA

    reverse(str.begin(), str.end());
    cout << str << "\n";//AA43211

    // stringstream
    string s1 = "111 222 333";
    stringstream ss(s1);
    string a1, b1, c1;
    ss >> a1 >> b1 >> c1;
    cout << a1 << " " << b1 << " " << c1 << "\n";//111 222 333

    string s2 = "111a222a333";
    stringstream ss2(s2);
    string a2, b2, c2;
    getline(ss2, a2, 'a');
    getline(ss2, b2, 'a');
    getline(ss2, c2, 'a');
    cout << a2 << " " << b2 << " " << c2 << "\n\n";

    // to_string
    string str123 = to_string(123);
    cout << "str123 : " << str123 << "\n\n";

    // atoi
    string b = "123";
    cout << "b: " << atoi(b.c_str()) << "\n";
    cout << "b: " << stoi(b) << "\n\n";

    // stoi
    string c = "A";
    cout << "c: " << atoi(c.c_str()) << "\n\n";
    // cout << "c: " << stoi(c) << "\n\n";

    // replace
    string origin = "01234567890";
    target = "AAAA";
    origin.replace(2, target.size(), target);
    cout << "origin: " << origin << "\n\n";

    


    return 0;
}