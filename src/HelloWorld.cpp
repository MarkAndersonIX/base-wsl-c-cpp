#include <stdio.h>
#include "HelloWorld.h"
#include <pybind11/pybind11.h>

namespace py = pybind11;

HelloWorld::HelloWorld(const std::string &name) : name(name) {}

void HelloWorld::sayHello(){
    printf("Hello %s, from pybind11!\n\n", HelloWorld::name.c_str());
}

PYBIND11_MODULE(helloworld, m) {
    py::class_<HelloWorld>(m, "HelloWorld")
        .def(py::init<const std::string &>())
        .def("sayHello", &HelloWorld::sayHello);
}