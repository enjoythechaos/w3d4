require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(el)
    self[el] << el unless include?(el)
    @count += 1
    resize! if @count > num_buckets
  end

  def remove(el)
    @count -= 1 if include?(el)
    self[el].delete(el)
  end

  def include?(el)
    self[el].include?(el)
  end

  private

  def [](el)
    # optional but useful; return the bucket corresponding to `el`
    hash_value = el.hash
    @store[hash_value % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_els = @store.flatten
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    old_els.each do |el|
      insert(el)
    end
  end
end
