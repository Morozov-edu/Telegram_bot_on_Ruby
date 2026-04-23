require 'mega_matrix'

include MegaMatrix
include Genetrix
include Arifmetrix
include Spectrix
include Accesstrix

def transfer_matrix(matrix_string)
    # Удаляем пробелы и скобки
    cleaned_string = matrix_string.gsub(/\s+/, '').gsub(/[\[\]]/, '')
    
    # Разделяем строки по запятой, учитывая вложенные массивы
    rows = cleaned_string.split('],[')

    # Преобразуем строки в массивы чисел
    matrix = Matrix.new(rows.map do |data|
        data.split(',').map(&:to_i)
    end)

    matrix
end


def sum_matrices(matrix1, matrix2)
    return nil unless matrix1.size == matrix2.size && matrix1[0].size == matrix2[0].size
    
    result = Array.new(matrix1.size) { Array.new(matrix1[0].size, 0) }
    
    matrix1.each_with_index do |row, i|
        row.each_with_index do |value, j|
            result[i][j] = value + matrix2[i][j]
        end
    end
    
    result
end