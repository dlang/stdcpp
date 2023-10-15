/*******************************************************************************

    Tests for std::list

*******************************************************************************/

module stdcpp.test.list;

import stdcpp.list;

unittest
{
    auto p = list!int(5);
    p.push_back(5);
    assert(p.sizeof == 24);
    assert(p.size() == 6);
    assert(p.front() == 0);
    assert(p.back() == 5);
    p.push_front(7);
    assert(p.front() == 7);
    p.clear();
    assert(p.size() == 0);
    p.assign(5,5);
    assert(p.size == 5);
    p.pop_front();
    assert(p.size == 4);
    p.resize(3);
    assert(p.size == 3);

    list!int cp_obj = p; //opAssign
    assert(cp_obj.size == 3);
    cp_obj.clear();
    cp_obj.push_back(45);
    cp_obj.push_back(56);
    assert(cp_obj.front == 45);
    assert(cp_obj.back == 56);
}
