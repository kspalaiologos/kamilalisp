
#ifndef _STACKTRACE_HPP
#define _STACKTRACE_HPP

#include <vector>
#include <string>
#include <exception>

extern thread_local std::vector<std::wstring> stacktrace;

void print_stack_trace();

class stacktrace_guard {
public:
    stacktrace_guard(std::wstring entry_name) { stacktrace.push_back(entry_name); }
    ~stacktrace_guard() { if (std::uncaught_exceptions() == 0) stacktrace.pop_back(); }
};

#endif
