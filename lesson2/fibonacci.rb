fibonacci_arr = [0, 1, 1]
while fibonacci_arr[-1] + fibonacci_arr[-2] < 100 do
  fibonacci_arr << fibonacci_arr[-1] + fibonacci_arr[-2]    
end
