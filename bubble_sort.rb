def bubble_sort (array)
  for iterations in 0..((array.length) -1)
    array.each_with_index do |number, index|
      if index < array.length
        if number > array[index+1]
          a = number
          b = array[index+1]
          array[index] = b
          array[index+1] = a
          print array
        end
      end
    end
  end
array
end

bubble_sort([4,3,2])
#bubble_sort([4,3,78,2,0,2])
