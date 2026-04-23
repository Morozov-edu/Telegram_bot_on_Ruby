# frozen_string_literal: true

module AdminsKeyboards
  def self.admin_panel
    Telegram::Bot::Types::ReplyKeyboardMarkup.new(
      keyboard: [
        [{ text: 'Админ панель' }]
      ],
      resize_keyboard: true
    )
  end
end
