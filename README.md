# MemcacheStat

This is Ruby library that fetches and wraps memcached stats output.

## Usage

Usage is simple:

    mcs = MemcacheStat.new
    mcs.get_hits          # => 2
    mcs.total_connections # => 34

To refresh the statistics:

    mcs.refresh!

By default, it connects to localhost:11211. If you need a different host or port:

    mcs = MemcacheStat.new("1.2.3.4", "11222")

## Copyright

Copyright (c) 2010 Joel Watson. See LICENSE for details.
