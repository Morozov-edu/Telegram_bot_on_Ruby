# frozen_string_literal: true

require_relative 'config'

Telegram::Bot::Client.run(TOKEN) do |bot|
    bot.api.get_updates(offset: -1)
    bot.listen do |update|
        
        AdminsRequests.handle(bot, update)
        UsersRequests.handle(bot, update)

    end
end