puts "Здравствуйте. Как вас зовут?" 
name = gets.chomp
puts "Укажите ваш рост."
height = gets.to_i
puts "Укажите ваш вес."
weight = gets.to_i

ideal_weight = height - 110

if (weight - ideal_weight) > 0 
  puts "#{name}, Ваш идеальный вес = #{ideal_weight}."
else 
  puts "#{name}, Ваш вес уже оптимальный"
end