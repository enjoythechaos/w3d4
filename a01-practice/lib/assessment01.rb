class Array
  def my_inject(accumulator = nil, &prc)
    copy = self.dup
    if accumulator.nil?
      accumulator = copy.shift
    end

    i = 0
    while i < copy.length
      accumulator = prc.call(accumulator, copy[i])
      i += 1
    end

    accumulator
  end
end

def is_prime?(num)
  return false if num < 2
  return true if num == 2

  i = 2
  while i < num
    return false if num % i == 0
    i += 1
  end

  true
end

def primes(count)
  i = 2
  counter = []
  while counter.length < count
    counter << i if is_prime?(i)
    i += 1
  end

  counter
end

# the "calls itself recursively" spec may say that there is no method
# named "and_call_original" if you are using an older version of
# rspec. You may ignore this failure.
# Also, be aware that the first factorial number is 0!, which is defined
# to equal 1. So the 2nd factorial is 1!, the 3rd factorial is 2!, etc.
def factorials_rec(num)
  return [1] if num == 1
  return [1, 1] if num == 2

  factorials_rec(num - 1) + [factorials_rec(num - 1).last * (num - 1)]
end

class Array
  def dups
    dup = Hash.new {[]}

    self.each_with_index do |el, idx|
      dup[el] = dup[el] + [idx]
    end

    dup.select {|_,value| value.length >= 2}
  end
end

class String
  def symmetric_substrings
    subs = []
    i = 0
    while i < length
      j = i + 1
      while j < length
        subs << self[i..j]
        j += 1
      end
      i += 1
    end

    subs.select {|el| el == el.reverse}
  end
end

class Array
  def merge_sort(&prc)
    return self if length < 2
    prc ||= Proc.new {|x,y| x.first <=> y.first }

    mid = length / 2
    left = take(mid)
    right = drop (mid)

    Array.merge(left.merge_sort(&prc), right.merge_sort(&prc), &prc)


  end

  private
  def self.merge(left, right, &prc)

    sorted = []

    until left.empty? || right.empty?
      case prc.call(left, right)
      when -1
        sorted << left.shift
      when 0
        sorted << left.shift
      when 1
        sorted << right.shift
      end
    end

    sorted.concat(left)
    sorted.concat(right)

  end
end
