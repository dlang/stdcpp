/*******************************************************************************

    Tests for `std::vector`

*******************************************************************************/

module stdcpp.test.vector;
import stdcpp.vector;
import stdcpp.allocator;
int a = 42;
int b = 9;
allocator!int alloc_instance = allocator!(int).init;
unittest
{
    auto vec = vector!int(4, alloc_instance);
    vec.push_back(a);
    assert(vec.length == 5);
    assert(vec[4] == 42);
	assert(vec.at(3) == 0);
	vec.pop_back();
	assert(vec.length == 4);
	vec.clear();
	assert(vec.empty == 1);
}



unittest
{
	auto p = vector!int(4, b, alloc_instance);
	assert(p.capacity() == 4);
	p.reserve(6);
	assert(p.capacity() == 6);
	//3 push backs to reallocate memory by 2 after initially capacity fills up
	p.push_back(a);
	p.push_back(a);//capacity is 6 now
	p.push_back(a);
	assert(p.capacity() == 12);
	p.resize(5);
	assert(p.length == 5);
	assert(p.sizeof == 24);//verifying three pointers
}
