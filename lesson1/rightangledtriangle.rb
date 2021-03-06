puts "Введите значения трёх сторон треугольника."
sides = [] #задал массив через [], а не Array.new
3.times { sides << gets.to_f } #исправил на флоат, чтобы значения могли быть не целыми.
sides.sort!

if sides.uniq.size == 1
  puts "Треугольник равнобедренный и равносторонний, но не прямоугольный"
elsif sides.uniq.size == 2  #исправил, теперь условие в той же строке что и elsif.
  puts "Треугольник прямоугольный и равнобедренный"
elsif sides[0] ** 2 + sides[1] ** 2 == sides[2] ** 2
  puts "Треугольник прямоугольный"
else
  puts "Треугольник не прямоугольный"
end