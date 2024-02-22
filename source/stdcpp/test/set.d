/*******************************************************************************

    Tests for `std::set`

*******************************************************************************/

module stdcpp.test.set;

import stdcpp.set;
import stdcpp.test.base;
import stdcpp.utility : less;
version (CppRuntime_Gcc)
{
    unittest
    {
        assert(cppSizeOf!(set!int) == set!int.sizeof);
    }

    unittest
    {
        import stdcpp.allocator;
        allocator!int alloc_instance = allocator!(int).init;
        less!int a;
        auto p = set!int(a);
        p.insert(5);
        assert(p.size == 1);
        assert(p.empty == 0);
        p.erase(5);
        p.insert(6);
        p.clear;
        assert(p.size == 0);
        assert(p.empty == 1);
        set!int q = a;
        q.swap(p);
        q.insert(4);
        q.insert(4);
        q.insert(4);
        assert(q.size == 1);
        assert(q.count(4) == 1);//count for set only results in 0 for not present or 1 for present
        assert(q.count(5) == 0);
        assert(q.contains(4) == 1); // q contains 4 evaluates to true
        auto iter = q.find(4);
        set!int w = q; //copy constructor
        assert(w.size() == 1);
        auto alloc = set!int(alloc_instance);
        alloc.insert(5);
        assert(alloc.size() == 1);
    }
}