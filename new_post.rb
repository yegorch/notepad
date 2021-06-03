require_relative 'lib/post'
require_relative 'lib/memo'
require_relative 'lib/link'
require_relative 'lib/task'

puts 'Привет, я простой блокнот!'
puts
puts 'Что хотите записать в блокнот?'

choices = Post.post_types.keys

choice = -1
until choice >= 0 && choice < choices.size
  choices.each_with_index do |type, index|
    puts "\t#{index}. #{type}"
  end
  choice = gets.to_i
end

entry = Post.create(choices[choice])

begin
  entry.read_from_console
rescue
  puts "Информация не валидна"
retry 
  entry.read_from_console
end  
# Сохраняем пост в базу данных
rowid = entry.save_to_db 

puts "Запись сохранена в базе, id = #{rowid}"
