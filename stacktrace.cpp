
#include "stacktrace.hpp"

#include <iostream>

thread_local std::vector<std::wstring> stacktrace;

void print_stack_trace() {
    std::wcout << L"At:" << std::endl;
    unsigned frame = 0;
    for(auto & s : stacktrace)
        std::wcout << L"#" << frame++ << L": " << s << std::endl;
}
