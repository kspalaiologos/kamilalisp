
#ifndef _LIST_HPP
#define _LIST_HPP

#include <memory>

template <typename T>
class node : std::enable_shared_from_this<node<T>> {
    public:
        node(std::shared_ptr<node> next, T value)
            : next(next), value(value) { }
        std::shared_ptr<node> next;
        T value;

        std::shared_ptr<node> clone() {
            if(next != nullptr)
                return std::make_shared<node>(next->clone(), value);
            else
                return nullptr;
        }

        std::shared_ptr<node> last() {
            if(next != nullptr)
                return next->last();
            else
                return this->shared_from_this();
        }
};

template <typename T>
class list {
    private:
        list(std::shared_ptr<node<T>> node_data)
            : node_data(node_data), last(node_data->last()) { }
        list(std::shared_ptr<node<T>> node_data, std::shared_ptr<node<T>> last)
            : node_data(node_data), last(last) { }
        std::shared_ptr<node<T>> node_data;
        std::shared_ptr<node<T>> last;

    public:
        class iterator {
            private:
                std::shared_ptr<node<T>> node_data;
                bool is_end;

            public:
                iterator(std::shared_ptr<node<T>> node_data)
                    : node_data(node_data), is_end(false) { }
                iterator(bool is_end)
                    : is_end(is_end) { }

                iterator operator++() {
                    if(!is_end) {
                        node_data = node_data->next;
                        if(node_data == nullptr)
                            is_end = true;
                    }
                    return *this;
                }

                bool operator!=(const iterator& other) {
                    return !(is_end == other.is_end);
                }

                T& operator*() {
                    return node_data->value;
                }

                T* operator->() {
                    return &node_data->value;
                }
        };

        list() : node_data(nullptr), last(nullptr) { }

        T car() {
            return node_data->value;
        }

        iterator begin() {
            return iterator(node_data);
        }

        iterator end() {
            return iterator(true);
        }

        list cdr() {
            return list(node_data->next, last);
        }

        list cons(T value) {
            if(!is_empty())
                return list(std::make_shared<node<T>>(node_data, value), last);
            else {
                std::shared_ptr<node<T>> ptr = std::make_shared<node<T>>(nullptr, value);
                return list(ptr, ptr);
            }
        }

        // unsafe append: everything that references the node data
        // will see the operation being reflected. use with caution.
        list unsafe_append(T value) {
            if(!is_empty())
                return list(node_data, last->next = std::make_shared<node<T>>(nullptr, value));
            else
                return list(std::make_shared<node<T>>(nullptr, value), std::make_shared<node<T>>(nullptr, value));
        }

        bool is_empty() {
            return node_data == nullptr;
        }

        list clone() {
            return list(node_data->clone());
        }

        T at(unsigned n) {
            auto it = node_data;
            for(unsigned i = 0; i < n; i++)
                it = it->next;
            return it->value;
        }

        unsigned size() {
            unsigned size = 0;
            auto it = node_data;
            while(it != nullptr) {
                size++;
                it = it->next;
            }
            return size;
        }

        bool operator==(list<T> &other) {
            auto it = node_data;
            auto other_it = other.node_data;
            while(it != nullptr && other_it != nullptr) {
                if(it->value != other_it->value)
                    return false;
                it = it->next;
                other_it = other_it->next;
            }
            return it == nullptr && other_it == nullptr;
        }

        template <typename IteratorType>
        static list<T> from(std::reverse_iterator<IteratorType> begin, std::reverse_iterator<IteratorType> end) {
            list<T> result {};
            for (auto it = begin; it != end; it++)
                result = result.cons(*it);
            return result;
        }

        static constexpr list from(std::initializer_list<T> data) {
            if(data.size() == 1)
                return list(std::make_shared<node<T>>(nullptr, *(data.begin())));
            else
                return from(std::rbegin(data), std::rend(data));
        }

        static constexpr list from(T data) {
            return list(std::make_shared<node<T>>(nullptr, data));
        }
};

#endif
