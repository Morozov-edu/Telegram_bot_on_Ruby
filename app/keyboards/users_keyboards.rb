# frozen_string_literal: true

module UsersKeyboards
    # Главное меню
    def self.main_kb
    Telegram::Bot::Types::InlineKeyboardMarkup.new(
        inline_keyboard: [
            [
                { text: 'Свободная арифметика', callback_data: 'free_arithmetic' }
            ],
            [
                { text: 'Сложение', callback_data: 'addition' },
                { text: 'Вычитание', callback_data: 'subtraction' },
            ],
            [
                { text: 'Умножение', callback_data: 'multiplication' },
                { text: 'Деление', callback_data: 'division' },
            ],
            [
                { text: 'Другие операции', callback_data: 'other_operations' },
            ]
        ]
        )
    end

    def self.main_multiplication_kb
        Telegram::Bot::Types::InlineKeyboardMarkup.new(
            inline_keyboard: [
                [
                    { text: 'Перемножение матриц', callback_data: 'multiplication_matrices' }
                ],
                [
                    { text: 'Умножение матрицы на число', callback_data: 'multiplication_number' }
                ],
                [
                    { text: 'Назад', callback_data: 'back_to_main' }
                ]
            ]
        )
    end

    # Назад в главное меню
    def self.back_to_main_kb
        Telegram::Bot::Types::InlineKeyboardMarkup.new(
            inline_keyboard: [
                [
                    { text: 'Назад', callback_data: 'back_to_main' }
                ]
            ]
        )
    end
end
