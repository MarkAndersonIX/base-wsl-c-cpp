#include <stdio.h>

using namespace std;
class HelloWorld {
    public: void sayHello(){
        printf("Hello World\n\n");
    }
};

int main() {
    HelloWorld hw = HelloWorld();
    hw.sayHello();
    return 0;
}