/**
 * D bindings for std::list
 *
 * Copyright: Copyright (c) 2023 D Language Foundation
 * License: Distributed under the
 *      $(LINK2 http://www.boost.org/LICENSE_1.0.txt, Boost Software License 1.0).
 *      (See accompanying file License)
 * Authors: Emmanuel Nyarko, Mathias Lang
 */
module stdcpp.list;

import stdcpp.allocator;

version (CppRuntime_Gcc)
{
    version (GLIBCXX_USE_CXX98_ABI)
    {
        private enum listNamespace = "std";
    }
    else
    {
        import core.internal.traits : AliasSeq;
        private enum listNamespace = AliasSeq!("std", "__cxx11");
    }
}
else
{
    import stdcpp.xutility : StdNamespace;
    alias listNamespace = StdNamespace;
}

enum def {value}; //for later use
extern(C++, (listNamespace)):

alias list(Type) = list!(Type, allocator!Type);

extern(C++, class) struct list(Type, Allocator)
{
    static assert(!is(Type == bool), " list not required to have specialization for bool");

    ///
    alias value_type = Type;

    ///
    alias allocator_type = Allocator;

    ///
    alias size_type = size_t;

    ///
    alias pointer = Type*;

    ///
    alias const_pointer = const(Type)*;

    ///
    alias difference_type = ptrdiff_t;

    ///
    ref list opAssign();

    ///
    @disable this() @safe pure nothrow @nogc scope;

    version (CppRuntime_Gcc)
    {
        version (GLIBCXX_USE_CXX98_ABI)
        {
            //allocator ctor
            this(ref const allocator!Type);

            //list(n,value) ctor until c++11
            this(size_type __n, ref const value_type value, ref const allocator!Type);

            /// Copy constructor
            this(ref const list!Type __x);

            extern(D) this(size_type n)
            {
                value_type type_instance = value_type.init;
                allocator!Type alloc_instance = allocator!(Type).init;
                this(n, type_instance, alloc_instance);
            }

            extern(D) void assign(size_type n, const value_type item)
            {
                this.assign(n, item);
            }

            extern(D) void push_back(const Type item)
            {
                this.push_back(item);
            }

            extern(D) void push_front(const Type item)
            {
                this.push_front(item);
            }

            extern(D) void remove(const value_type item)
            {
                this.remove(item);
            }

            void assign(size_type count, ref const value_type value);

            ref list opAssign(ref const list!Type other);

            //just const until c++11
            allocator_type get_allocator() const;

            ref value_type front();

//          const(value_type) ref front() const;

            ref value_type back();

            pointer begin();

            pointer end();

            //just const until c++11
            bool empty() const;

            size_type size() const;

            size_type max_size() const nothrow;

            void clear();

            //insert halted for now

            void push_back(ref const Type val);

            void pop_back();

            void push_front(ref const value_type val);

            void pop_front();

            void swap(ref const list!Type other);

            void merge( ref const list!Type other);

            void merge(U)(ref const list!Type other, U comp);

            void remove(const ref value_type val);

            void reverse();

            void sort();

            size_type unique();

            void sort(U)(U comp);

            private struct node
            {
                node* prev;
                node* next;
            }
            // pre-c++11 doesn't keep track of its size
            private node A;
        }
        else // !GLIBCXX_USE_CXX98_ABI
        {
            this(def)
            {
                allocator!Type alloc_instance = allocator!(Type).init;
                this(alloc_instance);
            }

             //allocator ctor
            this(ref const allocator!Type);

            // Copy constructor
            this(ref const list!Type __x);

             //list(n,value) ctor
            this(size_type __n, ref const value_type value, ref const allocator!Type);

            extern(D) this(size_type n, const value_type element)
            {
                allocator!Type alloc_instance = allocator!(Type).init;
                this(n, element, alloc_instance);
            }

            this(ref const list!Type other, ref const allocator!Type);

            //list(n) ctor
            this(size_type __n, ref const allocator!Type);

            extern(D) this(size_type n)
            {
                allocator!Type alloc_instance = allocator!(Type).init;
                this(n, alloc_instance);
            }

            extern(D) void assign(size_type n, const value_type item)
            {
                this.assign(n, item);
            }

            extern(D) void push_back(const Type item)
            {
                this.push_back(item);
            }

            extern(D) void push_front(const Type item)
            {
                this.push_front(item);
            }

            extern(D) void resize(size_type n, const value_type item)
            {
                this.resize(n, item);
            }

            extern(D) void remove(const value_type item)
            {
                this.remove(item);
            }

            ref list opAssign(ref const list!Type other);

            void assign(size_type count, ref const value_type value);

            //const nothrow since C++11
            allocator_type get_allocator() const nothrow;

            ref value_type front();

            ref value_type back();

            pointer begin() nothrow;

            pointer end() nothrow;

            //const nothrow since c++11
            bool empty() const nothrow;

            size_type size() const nothrow;

            void clear() nothrow;

            void push_back(ref const Type val);

            void pop_back();

            void push_front(ref const value_type val);

            void pop_front();

            void resize(size_type count);

            void resize(size_type count, ref const value_type val);

            void swap(ref const list!Type other) nothrow;

            void merge( ref const list!Type other);

            void merge(U)(ref const list!Type other, U comp);

            void remove(const ref value_type val);

            void reverse() nothrow;

            void sort();

            void sort(U)(U comp);

            void unique();

            void unique(U)(U p);

            size_type unique();

            size_type unique(U)(U p);

            private struct node
            {
                node* prev;
                node* next;
            }
            private node A;
            private size_type _M_size; //new list keeps track of it's size
        }
    }
    else version (CppRuntime_Clang)
    {
        this(def)
        {
            allocator!Type alloc_instance = allocator!(Type).init;
            this(alloc_instance);
        }

        ///
        this(ref const allocator!Type);

        /// Copy constructor
        this(ref const list!Type __x);

        ///
        this(size_type __n, ref const value_type value, ref const allocator!Type);

        extern(D) this(size_type n, const value_type element)
        {
            allocator!Type alloc_instance = allocator!(Type).init;
            this(n, element, alloc_instance);
        }

        this(ref const list!Type other, ref const allocator!Type);

        this(size_type __n, ref const allocator!Type);

        this(size_type n);

        ~this();

        extern(D) void assign(size_type n, const value_type item)
        {
            this.assign(n, item);
        }

        extern(D) void push_back(const Type item)
        {
            this.push_back(item);
        }

        extern(D) void push_front(const Type item)
        {
            this.push_front(item);
        }

        extern(D) void resize(size_type n, const value_type item)
        {
            this.resize(n, item);
        }

        extern(D) void remove(const value_type item)
        {
            this.remove(item);
        }

        ref list opAssign(ref const list!Type other);

        void assign(size_type count, ref const value_type value);

        allocator_type get_allocator() const nothrow;

        ref value_type front()
        {
            assert(!empty, "list.front called on empty list");
            return base.__end_.next.__as_node.__get_value;
        }

        ref value_type back()
        {
            assert(!empty, "list.back called on empty list");
            return base.__end_.prev.__as_node.__get_value;
        }

        pointer begin() nothrow;

        pointer end() nothrow;

        bool empty() const nothrow
        {
            return base.empty();
        }

        size_type size() const nothrow
        {
            return base.__sz();
        }

        void clear() nothrow
        {
            base.clear();
        }

        void push_back(ref const Type val);

        void pop_back();

        void push_front(ref const value_type val);

        void pop_front();

        void resize(size_type count);

        void resize(size_type count, ref const value_type val);

        void swap(ref const list!Type other) nothrow;

        void merge( ref const list!Type other);

        void merge(U)(ref const list!Type other, U comp);

        void remove(const ref value_type val);

        void reverse() nothrow;

        void sort();

        void sort(U)(U comp);

        void unique();

        void unique(U)(U p);

        private __list_imp!(value_type, allocator!Type) base;
    }
    else
    {
        static assert(0, "CppRuntime not yet supported");
    }
}

private:

version (CppRuntime_Clang)
{

    extern(C++) struct __list_node_base(Tp, Voidptr)
    {
        __list_node_base* prev;
        __list_node_base* next;

        __list_node_base* __self()
        {
            __list_node_base* self = &this;
            return self;
        }

        __list_node!(Tp, void*)* __as_node()
        {
            return cast(__list_node!(Tp, void*)*)__self;
        }
    }


    extern(C++) struct __list_node(Tp, _Voidptr)
    {
        __list_node_base!(Tp, void*) base1;
    private:
        union {
            Tp __value;
        };

    public:
        ref Tp __get_value()
        {
            return __value;
        }
    }

    extern(C++, class) struct __list_imp(Tp, Alloc)
    {
        alias value_tp = Tp;
        alias _alloc_traits = allocator_traits!(allocator!Tp);
        alias void_pointer = void*;
        //alias __rebind_alloc(Traits, Tp) = Traits.rebind_alloc!(Tp);

        //i can just use size_t here but
        alias size_type = allocator_traits!(allocator!Tp).size_type;
        alias __node_type = __list_node!(value_tp, void_pointer);
        alias __node_allocator = _alloc_traits.rebind_alloc!(__node_type);

        import stdcpp.xutility: __compressed_pair;
        __list_node_base!(value_tp, void_pointer) __end_;
        __compressed_pair!(size_type, __node_allocator) __size_alloc_;

        ref inout(size_type) __sz() nothrow inout
        {
            return __size_alloc_.first();
        }

        ref inout(__node_allocator) __node_alloc() inout nothrow
        {
            return __size_alloc_.second();
        }

        bool empty() const nothrow  {return __sz() == 0; }

        void __unlink_nodes(__list_node_base!(value_tp,void_pointer)* __f, __list_node_base!(value_tp, void_pointer)* __l) nothrow
        {
            __f.prev.next = __l.next;
            __l.next.prev = __f.prev;
        }

        void clear() nothrow;
    }
}
