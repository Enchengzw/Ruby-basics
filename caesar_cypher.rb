def defineshift(shift)
  if shift > 25
    shift = shift % 25
  elsif shift < -25
    shift = shift % 25
  end
shift
end

def upcase(integer, shift)
  integer += shift
  if integer > 90 
    integer -= 25
  elsif integer < 65
    integer += 25
  end
  integer
end

def lowercase(integer, shift)
  integer += shift
  if integer > 122 
    integer -= 25
  elsif integer < 97
    integer += 25
  end
  integer
end

def caesar_cipher(string, shift)
  array = string.codepoints 
  newarray = Array.new
  defineshift(shift)
  array.each do |ascii_value|
    if ascii_value.between?(97,122)
      newarray.push(lowercase(ascii_value, shift).chr)
    elsif ascii_value.between?(65,90)
      newarray.push(upcase(ascii_value, shift).chr)
    else
      newarray.push(ascii_value.chr)
    end
  end
 print newarray.join
end

caesar_cipher("Hi Apple!",1)