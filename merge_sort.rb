def merge_sort(array)
  if array.length < 2
    array
  else
    mid = array.length / 2
    left_array = merge_sort(array[0..mid - 1])
    right_array = merge_sort(array[mid..array.length - 1])
    merge(left_array, right_array)
  end
end

def merge(left_array, right_array)
  sorted_array = []
  while left_array.length > 0 && right_array.length > 0
    sorted_array << if left_array[0] > right_array[0]
                      right_array.slice!(0)
                    else
                      left_array.slice!(0)
                    end
  end

  sorted_array << left_array.slice!(0) while left_array.length > 0
  sorted_array << right_array.slice!(0) while right_array.length > 0

  sorted_array
end

print merge_sort([3, 6, 8, 5, 4, 2, 1])

