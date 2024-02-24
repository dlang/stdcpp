/*******************************************************************************

    Tests for `std::vector`

*******************************************************************************/

module stdcpp.test.vector;

import stdcpp.test.base;
import stdcpp.vector;

/// Test that the sizes matches
unittest
{
    assert(cppSizeOf!(vector!int) == vector!int.sizeof);
}

version (CppRuntime_Gcc)
{
    unittest
    {
        auto vec = vector!int(4);
        vec.push_back(42);
        assert(vec.length == 5);
        assert(vec[4] == 42);
        assert(vec.at(3) == 0);
        vec.pop_back();
        assert(vec.length == 4);
        vec.clear();
        assert(vec.empty == 1);
        vec.push_back(7);
        vector!int new_vec = vec; //opAssign test
        auto it = new_vec.begin();
        assert(*(it) == 7);
    }

    unittest
    {
        auto p = vector!int(4,9);
        assert(p.capacity() == 4);
        p.reserve(6);
        assert(p.capacity() == 6);
        //3 push backs to reallocate memory by 2 after initially capacity fills up
        p.push_back(9);
        p.push_back(9);//capacity is 6 now
        p.push_back(9);
        assert(p.capacity() == 12);
        p.resize(5);
        assert(p.length == 5);
        p.assign(3,8);
        assert(p.length == 3);
        p.push_back(4);
        p.push_back(9);
        auto iter = p.begin();
        //single iteration movements
        assert(*(iter) == 8);
        iter++;
        assert(*(iter) == 8);
        iter++;
        assert(*(iter) == 8);
        iter++;
        assert(*(iter) == 4);
        iter++;
        assert(*(iter) == 9); // 8,8,8,4,9 in that order
    }

    unittest
    {
        import stdcpp.allocator;
        allocator!int alloc_instance = allocator!(int).init;
        auto q = vector!int(alloc_instance);
        q.push_back(4);
        assert(q[0] == 4);
        assert(q.length == 1);
        auto cp_ctor = vector!int(q); // copy constructor
        assert(cp_ctor[0] == 4);
        assert(cp_ctor.length == 1);
        auto iter = cp_ctor.begin();
        assert(*(iter) == 4); // first element in vector
    }
}
else version (CppRuntime_Clang)
{
    unittest
    {
        auto vec = vector!int(5);
        assert(vec.length == 5);
        assert(vec[3] == 0);
        assert(vec.empty == 0);
        vec.reserve(6);
        assert(vec.capacity == 6);
        vec.assign(3,8);
        assert(vec.length == 3);
        assert(vec[0] == 8);
        assert(vec[1] == 8);
        assert(vec[2] == 8);
        vec.resize(9);
        assert(vec.size == 9);

        auto vec2 = vector!int(7,4);
        assert(vec2.size == 7);
        auto vec3 = vector!int(vec2); // copy ctor
        assert(vec3.size == 7);
        vec3.swap(vec);
        assert(vec3.size == 9); // after swap
        assert(vec.size == 7);
        vec.pop_back();
        assert(vec.size == 6);
        vec.pop_back();
        assert(vec.size == 5);
        vec.pop_back();
        assert(vec.size == 4);
    }
}
