arr = [10]
until arr[-1] == 100 do 
  arr << arr[-1] + 5 
end
