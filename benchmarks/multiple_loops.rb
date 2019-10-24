require 'benchmark'
require 'pp'

def single_main_loop(num_loops)
  a = b = c = d = e = f = g = h = 0

  num_loops.times do |i|
    a += 1
    b += 1
    c += 1
    d += 1
    e += 1
    f += 1
    g += 1
    h += 1
  end
  [a, b, c, d, e, f, g, h]
end

def multiple_main_loop(num_loops)
  a = b = c = d = e = f = g = h = 0

  num_loops.times do |i|
    a += 1
  end
  num_loops.times do |i|
    b += 1
  end
  num_loops.times do |i|
    c += 1
  end
  num_loops.times do |i|
    d += 1
  end
  num_loops.times do |i|
    e += 1
  end
  num_loops.times do |i|
    f += 1
  end
  num_loops.times do |i|
    g += 1
  end
  num_loops.times do |i|
    h += 1
  end
  [a, b, c, d, e, f, g, h]
end

raise "values do not match #{single_main_loop(100)} != #{multiple_main_loop(100)}" unless single_main_loop(100) == multiple_main_loop(100)

NUM_TESTS = 30
NUM_LOOPS = 2000000
single_time = 0
multiple_time = 0
Benchmark.bm(16) do |x|
  single_time   = x.report("Single Loop:    ") { NUM_TESTS.times { single_main_loop(NUM_LOOPS) } }
  multiple_time = x.report("Multiple Loops: ") { NUM_TESTS.times { multiple_main_loop(NUM_LOOPS) } }
end

puts "Single Loop is #{(100.0 * multiple_time.real / single_time.real).round(4)}% quicker with 1 vs 8 loops"

# Sample output
#                        user     system      total        real
# Single Loop:       5.470000   0.000000   5.470000 (  5.469783)
# Multiple Loops:   18.230000   0.010000  18.240000 ( 18.257371)
# Single Loop is 333.786% quicker with 1 vs 8 loops

