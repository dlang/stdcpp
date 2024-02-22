/**
 * D header file for interaction with C++ std::set.
 *
 * Copyright: Copyright (c) 2018 D Language Foundation
 * License: Distributed under the
 *      $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost Software License 1.0).
 *    (See accompanying file LICENSE)
 * Authors:   Emmanuel Nyarko
 */

module stdcpp.set;

import stdcpp.allocator;
import stdcpp.utility;
import stdcpp.xutility : StdNamespace;
extern(C++, (StdNamespace)):

alias set(Key) = set!(Key, less!Key, allocator!(Key));
extern(C++, class) struct set(Key, compare, Alloc)
{   ///
    alias key_type = Key;
    ///
    alias value_type = Key;
    ///
    alias size_type = size_t;
    ///
    alias difference_type = ptrdiff_t;
    ///
    alias key_compare = compare;
    ///
    alias value_compare = compare;
    ///
    alias allocator_type = Alloc;
    ///
    alias pointer = Key*;

    version (CppRuntime_Gcc)
    {
        ///
        this(const ref allocator!(Key));
        ///
        extern(D) this(const compare comp)
        {
            allocator!(Key) alloc_instance =  allocator!(Key).init;
            this(comp, alloc_instance);
        }

        this(const ref compare comp, ref const allocator!(Key) alloc);
        ///
        this(ref const set __x)
        {
            allocator!Key alloc_instance = allocator!Key.init;
            this(__x, alloc_instance);
        }
        ///
        this(ref const set!(Key) __x, ref const allocator!(Key));
        ///
        allocator_type get_allocator() const nothrow; 
        ///
        size_type size() const nothrow;
        ///
        bool empty() const nothrow;
        ///
        size_type max_size() const nothrow;
        ///
        void clear() nothrow;

        size_type erase(ref const Key key_var);
        ///
        extern(D) size_type erase(const Key item)
        {
            return this.erase(item);
        }
        ///
        extern(D) size_type count(const Key item) const
        {
            return this.count(item);
        }

        size_type count(const ref Key key_var) const;

        inout(pointer) find(const ref Key key_var) inout;
        ///
        extern(D) inout(pointer) find(const Key item) inout
        {
            return this.find(item);
        }

        pair!(pointer, bool) insert (ref const Key val);
        ///
        extern(D) pair!(pointer, bool) insert ( const Key val)
        {
            return this.insert(val);
        }
        ///
        void swap(ref set other) nothrow;
        ///
        void merge(C2)( ref set!(Key, C2, allocator!(Key)) source );

        bool contains(ref const Key key_var) const
        {
            return Rep_type.find(key_var) != Rep_type.end();
        }
        ///
        extern(D) bool contains(const Key item) const
        {
            return this.contains(item);
        }

        pair!(pointer, pointer) equal_range(ref const Key key_var);
        ///
        extern(D) pair!(pointer, pointer) equal_range(const Key item)
        {
            return equal_range(item);
        }

        inout(pointer) lower_bound(ref const Key key_var) inout;
        ///
        extern(D) inout(pointer) lower_bound( const Key item) inout
        {
            return lower_bound(item);
        }

        inout(pointer) lower_bound(K)(ref const K x) inout;
        ///
        extern(D) inout(pointer) lower_bound(Y)(const Y z) inout
        {
            return lower_bound!(Y)(z);
        }

        inout(pointer) upper_bound(K)(ref const K x) inout;
        ///
        extern(D) inout(pointer) upper_bound(Y)(const Y z) inout
        {
            return upper_bound!(Y)(z);
        }

        inout(pointer) upper_bound(K)(ref const K x) inout;
        ///
        extern(D) inout(pointer) upper_bound(Y)(const Y z) inout
        {
            return upper_bound!(Y)(z);
        }

        ///observers
        key_compare key_comp() const;
        ///
        value_compare value_comp() const;

        _Rb_tree!(key_type, value_type, _Identity!(value_type), key_compare, Alloc) Rep_type;
    }
    else version (CppRuntime_Microsoft)
    {
        static assert(0, "CppRuntime not yet supported");
    }
}

private:
version (CppRuntime_Gcc)
{
    extern(C++) struct _Identity(T)
    {

    }
    enum _Rb_tree_color { red = false, black = true};
    struct _Rb_tree_node_base
    {
        _Rb_tree_color _M_color;
        _Rb_tree_node_base* parent;
        _Rb_tree_node_base* left;
        _Rb_tree_node_base* right;
    }

    struct _Rb_tree_node(Val)
    {
        _Rb_tree_node_base _base;
        Val _M_value_field;
    }

    struct _Rb_tree_key_compare(U)
    {
        U _M_key_compare;
    }

    struct _Rb_tree_header
    {
        _Rb_tree_node_base _M_header;
        size_t _M_node_count;
    }

    extern(C++, class) struct _Rb_tree(_Key, _Val, _KeyOfValue, Compare, _Alloc)
    {
        alias pointer = _Key*;

        struct _Rb_tree_impl(_Key_compare)
        {
            _Rb_tree_header b;
            _Rb_tree_key_compare!(_Key_compare) a;
        }

        _Rb_tree_impl!Compare _M_impl;

        inout(pointer) end() inout nothrow;

        inout(pointer) find(const ref _Key __k) inout;
    }
}
