class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil, nxt = nil, prev = nil)
    @key, @val, @next, @prev = key, val, nxt, prev
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable

  attr_reader :head

  def initialize
    @head = Link.new
    @tail = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    # if empty?
    #   return nil
    # else
    #   last_link = first
    #   until last_link.next == nil
    #     last_link = last_link.next
    #   end
    #   last_link
    # end
    @tail
  end

  def empty?
    first.key == nil
  end

  def get(key)
    return nil if empty?
    target_link = first
    until target_link == nil || target_link.key == key
      target_link = target_link.next
    end
    target_link ? target_link.val : nil
  end

  def get_link(key)
    return nil if empty?
    target_link = first
    until target_link == nil || target_link.key == key
      target_link = target_link.next
    end
    target_link ? target_link : nil
  end

  def move_to_tail(link)
    return nil if link == @tail
    if link == @head
      @head = link.next
      @head.prev = nil
    else
      link.prev = @tail
      @tail.next = link
    end
    @tail = link
    link.next = nil

  end

  def include?(key)
    target_link = first
    until target_link == nil
      return true if target_link.key == key
      target_link = target_link.next
    end
    false
  end

  def insert(key, val)
    if empty?
      @head.key = key
      @head.val = val
      @tail = @head
    else
      @tail = last.next = Link.new(key, val, nil, @tail)
    end
  end

  def remove(key)
    return nil if empty?
    current_link = first
    if @head.key == key
      @head = @head.next
      if @head == nil
        @head = Link.new
      else
        @head.prev = nil
      end
    else
      loop do
        return nil if current_link == @tail && current_link.key != key
        break if current_link.key == key
        current_link = current_link.next
      end
      current_link.prev.next = current_link.next
      if current_link == @tail
        @tail = current_link.prev
      else
        current_link.next.prev = current_link.prev
      end
    end
  end

  def each(&prc)
    current_link = first
    loop do
      prc.call(current_link)
      return first if current_link == last
      current_link = current_link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end

# l = LinkedList.new
# l.insert(:first, 1)
# l.insert(:second, 2)
#
# p l[0]
