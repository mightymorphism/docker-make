# Copyright (c) 2018 Trough Creek Holdings, LLC.  All Rights Reserved

require 'shellwords'

def files_by_type(dname, typ = 'file', glob = '*', rej = [], incl = [])
  docker = []
  if ENV['BUILD_ROOT'] then
    docker_ignore = File.join(ENV['BUILD_ROOT'], '.dockerignore')
    if File.exists?(docker_ignore) then
        docker = File.read(docker_ignore).lines
        docker = docker.map { |l| l.sub(/#.*/, '').chomp }
        docker = docker.reject { |l| l =~ /^\s*$/ }
    end
  end

  res = Dir.entries(dname)
  res.reject! { |f| f == '.' || f == '..' }
  res.select! do |f|
    keep = true
    docker.each do |d|
      if d[0] != '!' then
        if File.fnmatch(d, f) then
          keep = false
        end
      elsif File.fnmatch(d[1..-1], f) then
        keep = true
      end
    end
    if keep &&  ENV['BUILD_ROOT'] then
      root = ENV['BUILD_ROOT']
      ef = Shellwords.escape(File.join(dname, f))
      keep = Kernel.system("cd #{root} && git ls-files --error-unmatch #{ef} 2> /dev/null > /dev/null")
    end
    keep
  end

  res.select! { |f| File.ftype(File.join(dname, f)) == typ }
  res.reject! { |f| rej.include?(f) }
  res.select! { |f| File.fnmatch(glob, f) }
  res += incl
  res.sort!
  return res
end
