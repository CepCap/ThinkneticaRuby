purchases = {}
loop do
  puts "Введите название товара. Для выхода введите \"Стоп\"."
  purchase = gets.chomp
  break if purchase.downcase == "стоп"
  puts "Введите цену товара."
  purchase_price = gets.to_f
  puts "Введите количество товара."
  purchase_amount = gets.to_f
  purchases[purchase] = { price: purchase_price, amount: purchase_amount }
end 

puts purchases

purchases.each do |purchase, atr|
  puts " Итоговая сумма за товар #{purchase} = #{atr[:price] * atr[:amount]}"
end
