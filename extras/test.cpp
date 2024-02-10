/*******************************************************************************

    C++ source code to support stdcpp unittests

    In order to ensure compatibility with C++, we instantiate those
    C++ templates (with gcc, clang, or cl) and use them from the D code.

*******************************************************************************/

#include <list>
#include <vector>

namespace stdcpp {
    namespace test {
        template<typename T>
        std::size_t cppSizeOf() {
            return sizeof(T);
        }
    };
};

template class std::list<int>;
template std::size_t stdcpp::test::cppSizeOf<std::list<int> >();

template class std::vector<int>;
template std::size_t stdcpp::test::cppSizeOf<std::vector<int> >();
