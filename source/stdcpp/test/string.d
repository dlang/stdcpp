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
    assert(a.capacity == stringCapacity("hello"));
}
