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

## Available Statistics

    Name                       Meaning
    ------------------------------------------------------------------------
    pid                        Process id of this server process
    uptime                     Number of seconds this server has been running
    time                       current UNIX time according to the server
    version                    Version string of this server
    pointer_size               Default size of pointers on the host OS (generally 32 or 64)
    rusage_user                Accumulated user time for this process (seconds:microseconds)
    rusage_system              Accumulated system time for this process (seconds:microseconds)
    curr_items                 Current number of items stored by the server
    total_items                Total number of items stored by this server ever since it started
    bytes                      Current number of bytes used by this server to store items
    curr_connections           Number of open connections
    total_connections          Total number of connections opened since the server started running
    connection_structures      Number of connection structures allocated by the server
    cmd_get                    Cumulative number of retrieval requests
    cmd_set                    Cumulative number of storage requests
    get_hits                   Number of keys that have been requested and found present
    get_misses                 Number of items that have been requested and not found
    evictions                  Number of valid items removed from cacheto free memory for new items
    bytes_read                 Total number of bytes read by this server from network
    bytes_written              Total number of bytes sent by this server to network
    limit_maxbytes             Number of bytes this server is allowed to use for storage.
    threads                    Number of worker threads requested.

## Copyright

Copyright (c) 2010 Joel Watson. See LICENSE for details.
