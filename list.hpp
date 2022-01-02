
#ifndef _LIST_HPP
#define _LIST_HPP

#include <memory>

template <typename T>
class node : public std::enable_shared_from_this<node<T>> {
    public:
        node(std::shared_ptr<node> next, T value)
            : next(next), value(value) { }
        virtual ~node() noexcept {
            while (next && next.use_count() < 2)
                next = std::move(next->next);
        }


        std::shared_ptr<node> next;
        T value;

        std::shared_ptr<node> clone() {
            if(next != nullptr)
                return std::make_shared<node>(next->clone(), value);
            else
                return std::make_shared<node>(nullptr, value);
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
        mutable std::size_t size_cache = 0;

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

        T & car() const {
            return node_data->value;
        }

        list reverse() const {
            list<T> instance { };
            for(auto it = this->begin(); it != this->end(); ++it)
                instance = instance.cons(*it);
            return instance;
        }

        iterator begin() const {
            if(is_empty())
                return iterator(true);
            return iterator(node_data);
        }

        iterator end() const {
            return iterator(true);
        }

        list cdr() const {
            return list(node_data->next, last);
        }

        list cons(T value) const {
            if(!is_empty())
                return list(std::make_shared<node<T>>(node_data, value), last);
            else {
                std::shared_ptr<node<T>> ptr = std::make_shared<node<T>>(nullptr, value);
                return list(ptr, ptr);
            }
        }
        
        // unsafe push_back.
        void push_back(T value) {
            if(is_empty()) {
                node_data = std::make_shared<node<T>>(nullptr, value);
                last = node_data;
            } else {
                last->next = std::make_shared<node<T>>(nullptr, value);
                last = last->next;
            }
            if(!size_cache) size();
            size_cache++;
        }

        // unsafe append: everything that references the node data
        // will see the operation being reflected. use with caution.
        list unsafe_append(T value) {
            if(!is_empty())
                return list(node_data, last->next = std::make_shared<node<T>>(nullptr, value));
            else {
                std::shared_ptr<node<T>> p = std::make_shared<node<T>>(nullptr, value);
                return list(p, p);
            }
        }

        list unsafe_append(list<T> value) {
            if(!is_empty()) {
                last->next = value.node_data;
                return list(node_data, value.last);
            } else
                return list(value.node_data, value.last);
        }

        bool is_empty() const {
            return node_data == nullptr;
        }

        list clone() const {
            std::shared_ptr<node<T>> p = node_data->clone();
            return list(p);
        }

        T at(std::size_t n) const {
            auto it = node_data;
            for(std::size_t i = 0; i < n; i++)
                it = it->next;
            return it->value;
        }

        void unsafe_reserve(std::size_t nodes, T value) {
            for(std::size_t i = 0; i < nodes; i++)
                last = last->next = std::make_shared<node<T>>(nullptr, value);
        }

        std::size_t size() const {
            if(size_cache == 0) {
                unsigned size = 0;
                auto it = node_data;
                while(it != nullptr) {
                    size++;
                    it = it->next;
                }
                return size_cache = size;
            } else {
                return size_cache;
            }
        }

        template<typename N>
        struct is_ptr : std::false_type {};
        template<typename N>
        struct is_ptr<std::shared_ptr<N>> : std::true_type {};

        bool operator==(const list<T> & other) const {
            if constexpr(is_ptr<T>::value) {
                auto it = node_data;
                auto other_it = other.node_data;
                while(it != nullptr && other_it != nullptr) {
                    if(it->value->operator!=(other_it->value))
                        return false;
                    it = it->next;
                    other_it = other_it->next;
                }
                return it == nullptr && other_it == nullptr;
            } else {
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
            auto ptr = std::make_shared<node<T>>(nullptr, data);
            return list(ptr, ptr);
        }
        
        static constexpr list from(const std::vector<T> & data) {
            from(data.begin(), data.end());
        }
};

#endif
