/*******************************************************************************

    C++ source code to support stdcpp unittests

    In order to ensure compatibility with C++, we instantiate those
    C++ templates (with gcc, clang, or cl) and use them from the D code.

*******************************************************************************/

#include <list>
#include <string>
#include <vector>

namespace stdcpp {
    namespace test {
        template<typename T>
        std::size_t cppSizeOf() {
            return sizeof(T);
        }

        /// Returns the result of `std::string` capacity with the provided string
        std::size_t stringCapacity (char const* str) {
            std::string s(str);
            return s.capacity();
        }
    };
};

template std::size_t stdcpp::test::cppSizeOf<std::string>();

template class std::list<int>;
template std::size_t stdcpp::test::cppSizeOf<std::list<int> >();

template class std::vector<int>;
template std::size_t stdcpp::test::cppSizeOf<std::vector<int> >();
