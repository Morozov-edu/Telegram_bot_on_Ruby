require 'mega_matrix'

include MegaMatrix
include Genetrix
include Arifmetrix
include Spectrix
include Accesstrix

def transfer_matrix(matrix_string)
  begin
    raise ArgumentError, "Input must be a String" unless matrix_string.is_a?(String)

    # Убираем лишние пробелы по краям
    str = matrix_string.strip

    # Проверка, что это похоже на массив
    unless str.start_with?('[') && str.end_with?(']')
      raise ArgumentError, "Invalid matrix format"
    end

    # Пробуем безопасно распарсить строку
    # Используем eval, но ограничиваем вход (только числа, запятые, скобки, минус)
    unless str.match?(/\A[\[\]\d,\s\-]+\z/)
      raise ArgumentError, "Matrix contains invalid characters"
    end

    data = eval(str)

    # Проверка: массив ли это вообще
    unless data.is_a?(Array)
      raise ArgumentError, "Parsed data is not an array"
    end

    # Если одномерный массив — превращаем в матрицу-строку
    if data.all? { |e| e.is_a?(Numeric) }
      matrix_data = [data]
    elsif data.all? { |row| row.is_a?(Array) }
      # Проверка, что все элементы — числа
      data.each do |row|
        unless row.all? { |e| e.is_a?(Numeric) }
          raise ArgumentError, "Matrix must contain only numbers"
        end
      end

      # Проверка, что матрица прямоугольная
      row_size = data.first.size
      unless data.all? { |row| row.size == row_size }
        raise ArgumentError, "Matrix rows must have одинаковую_длину"
      end

      matrix_data = data
    else
      raise ArgumentError, "Invalid matrix structure"
    end

    Matrix.new(matrix_data)

  rescue SyntaxError
    raise ArgumentError, "Invalid matrix syntax"
  rescue => e
    raise ArgumentError, "Error parsing matrix: #{e.message}"
  end
end


def sum_matrices(matrix1, matrix2)
    matrix1 + matrix2
rescue Arifmetrix::Error => e
    # Гем сам проверяет размеры и выбрасывает исключение при несовпадении
    $stderr.puts "Ошибка сложения: #{e.message}"
    nil
end

def subtract_matrices(matrix1, matrix2)
    matrix1 - matrix2
rescue Arifmetrix::Error => e
    $stderr.puts "Ошибка вычитания: #{e.message}"
    nil
end

def multiply_matrices(matrix1, matrix2)
    matrix1 * matrix2
rescue Arifmetrix::Error => e
    "Ошибка: #{e.message}"
end

def multiply_matrix_by_scalar(matrix, scalar)
    matrix * scalar
rescue => e
    "Ошибка: #{e.message}"
end

def division_matrix_by_scalar(matrix, scalar)
    matrix / scalar
rescue => e
    "Ошибка: #{e.message}"
end