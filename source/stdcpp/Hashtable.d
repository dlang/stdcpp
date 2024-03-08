/**
 * D header file for C++ Hashtable for unordered_map.
 *
 * Copyright: Copyright (c) 2018 D Language Foundation
 * License: Distributed under the
 *      $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost Software License 1.0).
 *    (See accompanying file LICENSE)
 * Authors:   Emmanuel Nyarko
 *            
 */
module stdcpp.Hashtable;

import stdcpp.allocator;
import stdcpp.utility : pair;
import stdcpp.xutility : StdNamespace;

extern(C++, (StdNamespace)):

version (CppRuntime_Gcc)
{
    /**
     * structs for hashtable template arguments to get the right mangling           
     */
    struct hash(T)
    {
    }

    struct equal_to(T = void)
    {
    }

    extern(C++, "__detail") struct _Select1st
    {
    }

    extern(C++, "__detail") struct _Mod_range_hashing
    {
    }

    extern(C++, "__detail") struct _Default_ranged_hash
    {
    }

    extern(C++, "__detail") struct _Prime_rehash_policy
    {
    }

    extern(C++, "__detail") struct _Hashtable_traits(bool _Cache_hash_code, bool _Constant_iterators, bool _Unique_keys)
    {
        import stdcpp.type_traits : bool_constant;
        alias __hash_cached = bool_constant!(_Cache_hash_code);
    }

    extern(C++, "__detail") struct _Hashtable_alloc(_NodeAlloc)
    {
        alias __node_base = _Hash_node_base;
        alias __node_base_ptr = __node_base*;
        alias __buckets_ptr = __node_base_ptr*;
    }

    extern(C++, "__detail") struct _Hash_node_base
    {
        _Hash_node_base* _M_next;
    }

    extern(C++, "__detail") struct _Hash_node(_Value, bool _Cache_hash_code)
    {
        _Hash_node_base __hb;
    }

    alias __umap_traits(bool _cache) = _Hashtable_traits!(_cache, false, true);

    alias __umap_hashtable(_Key, _Tp, _Hash, _Pred, Alloc, _Tr = __umap_traits!(false)) = _Hashtable!(_Key, pair!(const(_Key), _Tp), Alloc, _Select1st, _Pred, _Hash,
                                                                                _Mod_range_hashing, _Default_ranged_hash, _Prime_rehash_policy, _Tr );
    extern(C++, class) struct _Hashtable(_Key, _Value, _Alloc, _ExtractKey, _Equal,
                                         _Hash, _RangeHash, _Unused, _RehashPolicy, _Traits)
    {
        alias size_type = size_t;
        alias __traits_type = _Traits;
        alias __hash_cached = __traits_type.__hash_cached;
        alias __node_type = _Hash_node!(_Value, __hash_cached.value);
        alias __node_alloc_type = allocator_traits!(_Alloc).rebind_alloc!(__node_type);
        alias __hashtable_alloc = _Hashtable_alloc!(__node_alloc_type);
        alias __node_base = __hashtable_alloc.__node_base;
        alias __buckets_ptr = __hashtable_alloc.__buckets_ptr;
        alias __node_base_ptr = __hashtable_alloc.__node_base_ptr;
    
    private:

        __buckets_ptr _M_buckets;
        size_type _M_bucket_count = 1;
        __node_base _M_before_begin;
        size_type _M_element_count = 0;
        _RehashPolicy _M_rehash_policy;
        __node_base_ptr _M_single_bucket;
        void* _M_void;
    }
}
