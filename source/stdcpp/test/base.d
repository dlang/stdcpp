/*******************************************************************************

    Utilities to be used in tests

*******************************************************************************/

module stdcpp.test.base;

version (unittest):

/// Returns: the `sizeof` of `T` as seen by the C++ compiler
extern(C++, "stdcpp", "test") size_t cppSizeOf (T) ();
