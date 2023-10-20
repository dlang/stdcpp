/*******************************************************************************

    Tests for `std::vector`

*******************************************************************************/

module stdcpp.test.vector;
import stdcpp.vector;
import stdcpp.allocator;
int a = 42;
allocator!int alloc_instance = allocator!(int).init;
unittest
{
    auto vec = vector!int(4, alloc_instance);
    vec.push_back(a);
    assert(vec.length == 5);
    assert(vec[4] == 42);
}
