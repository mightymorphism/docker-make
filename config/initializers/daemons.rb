# Copyright (c) 2018 Trough Creek Holdings, LLC.  All Rights Reserved

require 'daemons'

module Daemonize
  def close_io
    $stderr.puts "override daemonize#close_io"

    ObjectSpace.each_object(IO) do |io|
      next if [$stdin, $stdout, $stderr].include?(io)
      if !io.is_a?(File) then
        next
      end

      begin
        io.close
      rescue Object => o
        $stderr.puts "objspace close: #{o.inspect}"
      end
    end
  end
  module_function :close_io
end
