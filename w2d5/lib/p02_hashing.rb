class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_str = ""
    each do |el|
      el.to_s.each_char { |char| hash_str << char.ord.to_s }
    end
    hash_str.to_i % 1000000000
  end
end

class String
  def hash
    split('').hash * "str".ord
  end
end

class Hash
  def hash
    hash_arr = []
    each do |k, v|
      hash_arr << "#{k}//#{v}"
    end
    hash_arr.sort.hash * "hash".ord
  end
end
