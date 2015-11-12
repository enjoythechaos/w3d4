require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    return false if bucket(key).empty?
    bucket(key).each do |link|
      return true if link.key == key
    end
    false
  end

  def set(key, val)
    delete(key)
    bucket(key).insert(key, val)
    @count += 1
    resize! if @count == num_buckets
  end

  def get(key)
    if include?(key)
      bucket(key).get(key)
    else
      nil
    end
  end

  def delete(key)
    @count -= 1 if include?(key)
    bucket(key).remove(key)
  end

  def each(&prc)
    @store.each do |bucket|
      bucket.each do |link|
        unless link == nil || link.key == nil
          prc.call(link.key, link.val)
        end
      end
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_buckets = @store
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    @count = 0
    old_buckets.each do |list|
      unless list.empty?
        list.each do |link|
          set(link.key, link.val)
        end
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    hash_value = key.hash
    @store[hash_value % num_buckets]
  end
end
