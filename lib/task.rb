class Task < Post
  def initialize
    super

    @due_date = Time.now
  end

  def read_from_console
    puts 'К какому числу? Укажите дату в формате ММ/ДД/ГГГГ, ' \
      'например 05/12/2003'
  
    input = STDIN.gets.chomp
    @due_date = Date.strptime(input, '%d/%m/%Y')
  
    puts 'Что надо сделать?'
    @text = STDIN.gets.chomp
  rescue ArgumentError => e
    puts "Не верная дата - #{e.message}. Введите дату еще раз"
    retry
  end

  def to_strings
    deadline = "Крайний срок: #{@due_date.strftime('%Y.%m.%d')}"
    time_string = "Создано: #{@created_at.strftime('%Y.%m.%d, %H:%M:%S')} \n"

    [deadline, @text, time_string]
  end

  def to_db_hash
    super.merge('text' => @text, 'due_date' => @due_date.to_s)
  end

  def load_data(data_hash)
    super

    @due_date = Date.parse(data_hash['due_date'])
  end
end
