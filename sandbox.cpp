#include <iostream>

using namespace std;

void stringMatching(string x) {
    string y = "asdkjfhlakhellokajhdflkhhellokajhdflkahhel adfkjhadsskflhjahgkjadh helh";

    int pos = 0;
    int index = 0;

    while((index = y.find(x, pos)) != string::npos) {
        cout << "Match found at " << pos << endl;
        pos = index + 1;
    }
}

int main() {
    string userInput;

    cout << "Input a String:\n";
    cin >> userInput;
    cout << endl;

    stringMatching(userInput);
}