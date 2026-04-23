require 'mega_matrix'

include MegaMatrix
include Genetrix
include Arifmetrix
include Spectrix
include Accesstrix

def transfer_matrix(matrix_string)
    cleaned_string = matrix_string.gsub(/\s+/, '').gsub(/[\[\]]/, '')
    
    rows = cleaned_string.split('],[')

    matrix_data = rows.map do |data|
        data.split(',').map(&:to_i)
    end

    Matrix.new(matrix_data)
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