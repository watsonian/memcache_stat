require 'rubygems'
require 'memcache_do'

class MemcacheStat
  attr_accessor :hostname,              #          Hostname to connect with
                :port,                  #          Port to connect with
                :raw,                   #          Raw stats output from memcache
                :pid,                   # 32u      Process id of this server process
                :uptime,                # 32u      Number of seconds this server has been running
                :time,                  # 32u      current UNIX time according to the server
                :version,               # string   Version string of this server
                :pointer_size,          # 32       Default size of pointers on the host OS (generally 32 or 64)
                :rusage_user,           # 32u:32u  Accumulated user time for this process (seconds:microseconds)
                :rusage_system,         # 32u:32u  Accumulated system time for this process (seconds:microseconds)
                :curr_items,            # 32u      Current number of items stored by the server
                :total_items,           # 32u      Total number of items stored by this server ever since it started
                :bytes,                 # 64u      Current number of bytes used by this server to store items
                :curr_connections,      # 32u      Number of open connections
                :total_connections,     # 32u      Total number of connections opened since the server started running
                :connection_structures, # 32u      Number of connection structures allocated by the server
                :cmd_get,               # 64u      Cumulative number of retrieval requests
                :cmd_set,               # 64u      Cumulative number of storage requests
                :get_hits,              # 64u      Number of keys that have been requested and found present
                :get_misses,            # 64u      Number of items that have been requested and not found
                :evictions,             # 64u      Number of valid items removed from cache to free memory for new items
                :bytes_read,            # 64u      Total number of bytes read by this server from network
                :bytes_written,         # 64u      Total number of bytes sent by this server to network
                :limit_maxbytes,        # 32u      Number of bytes this server is allowed to use for storage. 
                :threads                # 32u      Number of worker threads requested. (see doc/threads.txt)
  
  def initialize(hostname="localhost", port="11211")
    @hostname, @port = hostname, port
    refresh_raw_stats!
    parse_stats(@raw)
  end
  
  def refresh!
    refresh_raw_stats!
    parse_stats(@raw)
    true
  end
  
private
  def refresh_raw_stats!
    @raw = MemcacheDo.exec("stats", @hostname, @port)
  end

  def parse_stats(raw_stats)
    raw_stats.split("\r\n").each do |line|
      begin
        elements = line.split(" ")
        unless elements.first == "END"
          case elements[2]
          when /[0-9]+\.[0-9]+$/
            instance_variable_set("@#{elements[1]}".to_sym, elements[2].to_f)
          when /[0-9]+$/
            instance_variable_set("@#{elements[1]}".to_sym, elements[2].to_i)
          else
            instance_variable_set("@#{elements[1]}".to_sym, elements[2])
          end
        end
      rescue => e
        puts e
      end
    end
  end
end