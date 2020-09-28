def fib(n)
  n == 0 ? 0 : n == 1 ? 1 : fib(n - 2) + fib(n - 1)
end

def fibs(n)
  0.upto(n) do |i|
    puts fib(i)
  end
end

def fibs_rec(n, w= n)
  return fib(n) if w == 0 
  print "#{fib(n - w)} "
  fibs_rec(n, w - 1)
end

puts fibs_rec(10)