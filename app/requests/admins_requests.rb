# frozen_string_literal: true

module AdminsRequests
  ADMIN_IDS = [123456789] # вставь свой id

  def self.admin?(user_id)
    ADMIN_IDS.include?(user_id)
  end

  def self.handle(bot, message)
    return unless message.is_a?(Telegram::Bot::Types::Message)
    return unless admin?(message.from.id)

    case message.text
    when '/admin'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: 'Админ панель',
        reply_markup: AdminsKeyboards.admin_panel
      )
    end
  end
end
