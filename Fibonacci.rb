def fib(number)
  fibonacci = []
  i = 0
  while i <= number
    if i == 0
      fibonacci.push(0)
    elsif i == 1
      fibonacci.push(1)
    else
      fibonacci.push(fibonacci[i - 1] + fibonacci[i - 2])
    end
    i += 1
  end
  fibonacci
end

def fib_recursive(number)
  if number == 0
    0
  elsif number == 1
    1
  else
    fib_recursive(number - 1) + fib_recursive(number - 2)
  end
end

def register_to_array(number)
  i = number
  array = []
  while i >= 0
    array.unshift(fib_recursive(i))
    i -= 1
  end
  array
end

