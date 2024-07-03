#include <string>

class HelloWorld {
    public:
        explicit HelloWorld(const std::string &name);  // Explicit to avoid implicit conversions
        void sayHello();
    private:
        std::string name;
};