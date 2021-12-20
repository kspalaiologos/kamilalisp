
#ifndef _ENV_HPP
#define _ENV_HPP

#include "atom.hpp"

#include <unordered_map>
#include <memory>
#include <iterator>
#include <string>

class environment {
    private:
        std::unordered_map<std::wstring, atom> data;

    public:
        std::shared_ptr<environment> ancestor;

        environment() : ancestor(nullptr) { }
        environment(std::shared_ptr<environment> ancestor) : ancestor(ancestor) { }

        atom get(std::wstring key);
        void set(std::wstring key, atom value);
        void remove(std::wstring key);
        bool has(std::wstring key);
        std::shared_ptr<environment> get_topmost_ancestor();

        template <typename BiFunctor>
        void for_each(BiFunctor f) {
            for (auto it = data.begin(); it != data.end(); it++)
                f(it->first, it->second);
        }
};

#endif
