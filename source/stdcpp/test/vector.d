/*******************************************************************************

    Tests for `std::vector`

*******************************************************************************/

module stdcpp.test.vector;

import stdcpp.vector;

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
    assert(p.sizeof == 24);//verifying three pointers
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
