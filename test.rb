def permute(array)
  return array if array.size <= 1

  result = []

  array.each do |el|
    new_array = array.dup
    new_array.delete(el)
    result += permute(new_array).map do |perm|
      if perm.is_a?(Array)
        [el] + perm
      else
        [el] + [perm]
      end
    end
  end
  result
end

p permute(['a', 'b', 'c'])
