class Task < Post
  def initialize
    super

    @due_date = Time.now
  end

  def read_from_console
    puts 'Что надо сделать?'
    @text = STDIN.gets.chomp

    puts 'К какому числу? Укажите дату в формате ММ/ДД/ГГГГ, ' \
      'например 05/12/2003'
    input = STDIN.gets.chomp
  
    begin
      @due_date = Date.parse(input)
    rescue Date::Error
      puts "Не верная дата. Введите дату еще раз"
      input = STDIN.gets.chomp
    retry
      input = STDIN.gets.chomp
    end
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
