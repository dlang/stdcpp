/*******************************************************************************

    Tests for `std::string`

*******************************************************************************/

module stdcpp.test.string;

import stdcpp.test.base;
import stdcpp.string;

extern(C++, "stdcpp", "test") size_t stringCapacity (const(char)* str);

/// Test that the sizes matches
unittest
{
    assert(cppSizeOf!(std_string) == std_string.sizeof);
}

unittest
{
    auto a = std_string("hello");
    a.push_back('a');
    assert(a.size() == 6);
    // verifying small string optimization, this is 15 on GCC, 22-23 on clang
    assert(a.capacity == stringCapacity("helloa"));
    assert(a.front() == 'h');
    assert(a.back() == 'a');
    a.resize(4); // shrinks a to "hell"
    assert(a.size() == 4);
    immutable LongStr = "Hi, this is a test for string capacity growth for a length more than the base SSO";
    auto b = std_string(LongStr);
    assert(b.capacity == stringCapacity(LongStr.ptr));
    a.swap(b); // a and b swaps
    assert(a.capacity == stringCapacity(LongStr.ptr));
    assert(b.capacity == stringCapacity("hell")); // a was shrinked to hell so b contains 'hell'
    b.pop_back();
    assert(b.size() == 3);
    assert(b[0] == 'h');
    assert(b[1] == 'e');
    assert(a.empty == 0);
    a.clear();
    assert(a.empty == 1);
}
