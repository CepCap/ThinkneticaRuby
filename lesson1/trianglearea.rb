puts "Введите основание."
base = gets.to_f # исправил на флоат, чтобы значения могли быть не целыми.
puts "Введите высоту."
height = gets.to_f

area = ( base * 0.5) * height

puts "Площадь треугольника = #{area}."