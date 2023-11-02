/****************************************************************

		Test for 'std::string'

****************************************************************/

module stdcpp.test.string;
import stdcpp.string;


unittest
{
	auto a = std_string("hello");
	a.push_back('a');
	assert(a.size() == 6);
	assert(std_string.sizeof == 32);
	assert(a.capacity == 15);//verifying small string optimization
}
