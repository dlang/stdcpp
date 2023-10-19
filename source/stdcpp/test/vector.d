/*******************************************************************************

    Tests for `std::vector`

*******************************************************************************/

module stdcpp.test.vector;

import stdcpp.vector;
int a  = 42;
unittest
{
    vector!int p = 5;
    p.push_back(a);
    assert(p.length == 6);
    assert(p[0] == 0);
}
