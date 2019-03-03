months = { январь: 31, февраль: 28, март: 31, апрель: 30, май: 31, июнь: 30, июль: 31, август: 31, сентябрь: 30, октябрь: 31, ноябрь: 30, декабрь: 31}
date_pos = 0

puts "Введите число, месяц и год."
day = gets.to_i
user_month = gets.chomp.downcase
year = gets.to_f

leap = false
leap = year.divmod(4)[1] == 0 || year.divmod(400)[1] == 0 unless year.divmod(100)[1] == 0
leap = true if year == 2000

if leap == true 
  months[:февраль] = 29
end

months.each do |month, days|
  if month.to_s == user_month
    date_pos += day 
    break
  end
  date_pos += days
end

puts date_pos
