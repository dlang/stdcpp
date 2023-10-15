/*******************************************************************************

    Tests for `std::vector`

*******************************************************************************/

module stdcpp.test.vector;

import stdcpp.vector;

unittest
{
    auto p = vector!int(5);
    p.push_back(42);
    assert(p.length == 6);
    assert(p[0] == 0);
}
