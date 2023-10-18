def roman_map(hash, integer, accumulator = '')
  if integer == 0
    accumulator
  else
    hash.each do |key, value|
      result = integer.divmod(key)
      next unless result[0] >= 1

      accumulator += value * result[0]
      return roman_map(hash, result[1], accumulator)
    end
  end
end

roman_mapping = {
  1000 => 'M',
  900 => 'CM',
  500 => 'D',
  400 => 'CD',
  100 => 'C',
  90 => 'XC',
  50 => 'L',
  40 => 'XL',
  10 => 'X',
  9 => 'IX',
  5 => 'V',
  4 => 'IV',
  1 => 'I'
}

A = [0,1,2,3,4,5,6]

puts A[0..-2]

