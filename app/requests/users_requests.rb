module UsersRequests
  def self.handle(bot, update)

    # MESSAGE
    if update.is_a?(Telegram::Bot::Types::Message)
      user_id = update.from.id
      state = FSM.get(user_id) # ?

      # FSM
      case state

      when States::WAITING_MATRIX_1
        FSM.set_data(user_id, :matrix1, update.text)
        FSM.get_data(user_id, :sign)
        if sign == :waiting_scalar 
          FSM.set(user_id, States::WAITING_SCALAR)
          bot.api.send_message(
            chat_id: update.chat.id,
            text: "Введи теперь число (просто число)",
            reply_markup: UsersKeyboards.back_to_main_kb
          )

        else 
          FSM.set(user_id, States::WAITING_MATRIX_2)
          bot.api.send_message(
            chat_id: update.chat.id,
            text: "Введи вторую матрицу",
            reply_markup: UsersKeyboards.back_to_main_kb
          )
        end
        return

      when States::WAITING_SCALAR
        sign = FSM.get_data(user_id, :sign)
        matrix1 = FSM.get_data(user_id, :matrix1)

        scalar = update.text
        matrix1 = transfer_matrix(matrix1)

        if sign == :mult_matrix_num
          mult_n_result = multiply_matrix_by_scalar(matrix1, scalar)
            bot.api.send_message(
              chat_id: update.chat.id,
              text: "Матрица 1:\n#{matrix1}\n\nСкаляр:\n#{scalar}\n\nРезультат:\n#{mult_n_result}",
              reply_markup: UsersKeyboards.back_to_main_with_res_kb
            )
        end

      when States::WAITING_MATRIX_2
        sign = FSM.get_data(user_id, :sign)
        matrix1 = FSM.get_data(user_id, :matrix1)
        matrix2 = update.text

        matrix1 = transfer_matrix(matrix1)
        matrix2 = transfer_matrix(matrix2)

        if sign == :plus
            sum_result = sum_matrices(matrix1, matrix2)
            bot.api.send_message(
              chat_id: update.chat.id,
              text: "Матрица 1:\n#{matrix1}\n\nМатрица 2:\n#{matrix2}\n\nСумма:\n#{sum_result}",
              reply_markup: UsersKeyboards.back_to_main_with_res_kb
            )
        elsif sign == :minus
            subs_result = subtract_matrices(matrix1, matrix2)
            bot.api.send_message(
              chat_id: update.chat.id,
              text: "Матрица 1:\n#{matrix1}\n\nМатрица 2:\n#{matrix2}\n\nРазность:\n#{subs_result}",
              reply_markup: UsersKeyboards.back_to_main_with_res_kb
            )
        elsif sign == :mult_matrix
            mult_result = multiply_matrices(matrix1, matrix2)
            bot.api.send_message(
              chat_id: update.chat.id,
              text: "Матрица 1:\n#{matrix1}\n\nМатрица 2:\n#{matrix2}\n\nПроизведение:\n#{mult_result}",
              reply_markup: UsersKeyboards.back_to_main_with_res_kb
            )
        end

        FSM.clear(user_id)
        return
      end

      # Обычные команды
      case update.text

      when '/start'
        bot.api.send_message(
          chat_id: update.chat.id,
          text: 'Главное меню',
          reply_markup: UsersKeyboards.main_kb
        )
      
      when '/help'
        bot.api.send_message(
          chat_id: update.chat.id,
          text: "Этот бот предназначен для выполнения операций над матрицами. Выберите операцию в главном меню и следуйте инструкциям.",
          reply_markup: UsersKeyboards.back_to_main_kb
        )
      end

    end

    # CALLBACK
    if update.is_a?(Telegram::Bot::Types::CallbackQuery)
      user_id = update.from.id

      case update.data

      when 'addition'
        FSM.set(user_id, States::WAITING_MATRIX_1)
        FSM.set_data(user_id, :sign, :plus)

        bot.api.edit_message_text(
          chat_id: update.message.chat.id,
          message_id: update.message.message_id,
          text: "Введи первую матрицу в формате:\n[[1,2],[3,4]]",
          reply_markup: UsersKeyboards.back_to_main_kb
        )
      
      when 'subtraction'
        FSM.set(user_id, States::WAITING_MATRIX_1)
        FSM.set_data(user_id, :sign, :minus)

        bot.api.edit_message_text(
          chat_id: update.message.chat.id,
          message_id: update.message.message_id,
          text: "Введи первую матрицу в формате:\n[[1,2],[3,4]]",
          reply_markup: UsersKeyboards.back_to_main_kb
        )

      when 'back_to_main'
        FSM.clear(user_id)

        bot.api.edit_message_text(
          chat_id: update.message.chat.id,
          message_id: update.message.message_id,
          text: 'Главное меню',
          reply_markup: UsersKeyboards.main_kb
        )

      when 'back_to_main_w_res'
        FSM.clear(user_id)

        bot.api.send_message(
          chat_id: update.message.chat.id,
          message_id: update.message.message_id,
          text: 'Главное меню',
          reply_markup: UsersKeyboards.main_kb
        )
      
      when 'multiplication'
        bot.api.edit_message_text(
          chat_id: update.message.chat.id,
          message_id: update.message.message_id,
          text: 'Выберите тип умножения',
          reply_markup: UsersKeyboards.main_multiplication_kb
        )

      when 'multiplication_matrices'
        FSM.set(user_id, States::WAITING_MATRIX_1)
        FSM.set_data(user_id, :sign, :mult_matrix)

        bot.api.edit_message_text(
          chat_id: update.message.chat.id,
          message_id: update.message.message_id,
          text: "Введи первую матрицу в формате:\n[[1,2],[3,4]]",
          reply_markup: UsersKeyboards.back_to_main_kb
        )
      
      when 'multiplication_number'
        FSM.set(user_id, States::WAITING_MATRIX_1)
        FSM.set_data(user_id, :sign, :mult_matrix_num)

        bot.api.edit_message_text(
          chat_id: update.message.chat.id,
          message_id: update.message.message_id,
          text: "Введи первую матрицу в формате:\n[[1,2],[3,4]]",
          reply_markup: UsersKeyboards.back_to_main_kb
        )


      end

      bot.api.answer_callback_query(callback_query_id: update.id)
    end
  end
end