puts "Введите три коэффициента a, b и c"
a = gets.to_f #исправил на флоат, чтобы коэффициенты могли быть не целыми.
b = gets.to_f
c = gets.to_f

discriminant = b ** 2 - 4 * a * c

#убрал не нужный массив, проверка дискриминанта происходит 1 раз, так же как и вычисление квадратного корня.

if discriminant < 0 
  puts "Дискриминант = #{discriminant}. Корней нет."
elsif discriminant == 0
  puts "Дискриминант = #{discriminant}. Корень уравнения = #{(-b + Math.sqrt(discriminant)) / 2 * a}"
elsif discriminant > 0
  puts "Дискриминант = #{discriminant}. Корни уравнения = #{(-b + Math.sqrt(discriminant)) / 2 * a}, #{(-b - Math.sqrt(discriminant)) / 2 * a}"
end