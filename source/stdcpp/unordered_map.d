/**
 * D header file for interaction with C++ std::unordered_map.
 *
 * Copyright: Copyright (c) 2018 D Language Foundation
 * License: Distributed under the
 *      $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost Software License 1.0).
 *    (See accompanying file LICENSE)
 * Authors:   Emmanuel Nyarko
 */

module stdcpp.unordered_map;

import stdcpp.allocator;
import stdcpp.Hashtable;
import stdcpp.utility : pair;
import stdcpp.xutility : StdNamespace;
extern(C++, (StdNamespace)):

alias unordered_map(Key, value) = unordered_map!(Key, value, hash!Key, equal_to!Key, allocator!(pair!(const(Key), value)));
extern(C++, class) struct unordered_map(Key, value, Hash, KeyEqual, Alloc)
{   ///
    alias key_type = Key;
    ///
    alias mapped_value = value;
    ///
    alias size_type = size_t;
    ///
    alias difference_type = ptrdiff_t;
    ///
    alias key_equal = KeyEqual;
    ///
    alias allocator_type = Alloc;
    ///
    alias Pair = pair!(const(Key), value);
    ///
    alias pointer = allocator_traits!(allocator_type).pointer;

    alias _Hashtable = __umap_hashtable!(Key, value, Hash, KeyEqual, Alloc);

    version(CppRuntime_Gcc)
    {
        ///
        extern(D) this(size_type __x)
        {
            allocator_type alloc_instance = allocator_type.init;
            Hash hash_instance = Hash.init;
            key_equal equal_instance = key_equal.init;
            this(__x, hash_instance, equal_instance, alloc_instance);
        }
        ///
        this(size_type bucket_count, const ref allocator_type);
        ///
        extern(D) this(const ref unordered_map __a)
        {
            allocator_type alloc_instance = allocator_type.init;
            this(__a, alloc_instance);
        }

        //only bucket_count is non-default, rest are default. called from 'extern(D) this(size_type __x)'
        this(size_type bucket_count, const ref Hash hash, const ref key_equal equal, const ref allocator_type __x);

        this(const ref unordered_map __x, const ref allocator_type __a);

        pair!(pointer, bool) insert(const ref Pair item);

        ///capacity
        bool empty() const;
        ///
        size_t size() const;
        ///
        size_t max_size() const;

        ///Modifiers
        void clear();
        ///
        extern(D) pair!(pointer, bool) insert(const key_type key, value val)
        {
            Pair item = {key, val};
            return insert(item);
        }
        ///
        void swap(ref unordered_map other) nothrow;

        ///bucket interface
        size_type bucket_count() const;
        ///
        size_type bucket_size(size_type n) const;


        ///Hash policy
        float load_factor() const;
        ///
        void max_load_factor(float ml);
        ///
        float max_load_factor() const;
        ///
        void rehash(size_type count);
        ///
        void reserve(size_type count);

    private _Hashtable _M_h;
    }
}
