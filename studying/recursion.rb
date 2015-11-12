require 'byebug'

def range(start, stop)
  return [] if stop < start

  [start] + range(start + 1, stop)
end

def sum(array)
  return array.first if array.length <= 1

  array.first + sum(array.drop(1))
end

def sum_it(array)
  array.inject(0) { |a, el| a + el }
end

# def exp(base, power)
#   return 1 if power == 0
#
#   base * exp(base, power - 1)
# end

def exp(base, power)
  return 1 if power == 0
  return base if power == 1

  if power.even?
    exp(base, power/2) * exp(base, power/2)
  else
    base * exp(base, (power - 1)/2) * exp(base, (power - 1)/2)
  end
end

class Array

  def deep_dup
    return self.dup if none? { |el| el.is_a?(Array) }

    dupped = []
    each do |el|
      if el.is_a?(Array)
        dupped << el.deep_dup
      else
        dupped << el
      end
    end

    dupped
  end
end

def fibonacci(num)
  return [1] if num == 1
  return [1,1] if num == 2

  fibonacci(num - 1) + [fibonacci(num - 1).last + fibonacci(num - 2).last]
end

def fib_it(num)
  return [1] if num == 1
  return [1,1] if num == 2

  fib_nums = [1,1]
  while fib_nums.length < num
    fib_nums << (fib_nums[-1] +fib_nums[-2])
  end

  fib_nums
end

def bsearch(array, target)
  return nil if array.count == 0

  mid_point = array.length / 2

  case array[mid_point] <=> target
  when -1
    answer = bsearch(array.drop(mid_point + 1), target)
    if answer.nil?
      nil
    else
      mid_point + 1 + answer
    end
  when 0
    return mid_point
  when 1
    bsearch(array.take(mid_point), target)
  end
end

def make_change(total, coins)
  coins = coins.sort.reverse
  return [] if total == 0

  until coins.first <= total
    #debugger
    coins.shift
  end
  shortest = nil
  coins.each do |coin|
    change = [coin] + make_change(total - coin, coins)
    if shortest.nil? || change.length < shortest.length
      shortest = change
    end
  end

  shortest
end

def merge_sort(array)
  return array if array.length <= 1

  mid = array.length / 2

  right = array.drop(mid)
  left = array.take(mid)
  p left
  p right

  merge(merge_sort(left), merge_sort(right))

end


def merge(left, right)
  sorted = []

  until left.empty? || right.empty?
    case left.first <=> right.first
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

# p merge_sort([4,2,6,3,5,8])

# def subsets(array)
#   return [[]] if array.empty?
#   value = subsets(array[0...-1])
#   value.concat(value.map {|el| el + [array.last]} )
# end

p subsets([]) # => [[]]
p subsets([1]) # => [[], [1]]
p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
p subsets([1, 2, 3])
# => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]


















#
