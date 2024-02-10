/*******************************************************************************

    C++ source code to support stdcpp unittests

    In order to ensure compatibility with C++, we instantiate those
    C++ templates (with gcc, clang, or cl) and use them from the D code.

*******************************************************************************/

#include <list>
#include <vector>

template class std::list<int>;
template class std::vector<int>;
