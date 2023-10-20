/*******************************************************************************

    Tests for `std::vector`

*******************************************************************************/

module stdcpp.test.vector;

import stdcpp.vector;

unittest
{
    vector!int vec;
    vec.push_back(42);
    assert(vec.length == 1);
    assert(vec[0] == 42);
}
