
#ifndef _STACKTRACE_HPP
#define _STACKTRACE_HPP

#include <vector>
#include <string>

extern thread_local std::vector<std::wstring> stacktrace;

void print_stack_trace();

#endif
