
# frozen_string_literal: true

TOKEN = '5348913038:AAHkXy_H0Quo1LqsaGjfx7Gp1HswF2Ya2f0'

require 'telegram/bot'


require_relative 'app/keyboards/users_keyboards'
require_relative 'app/keyboards/admins_keyboards'
require_relative 'app/requests/users_requests'
require_relative 'app/requests/admins_requests'
require_relative 'app/services/fsm'
require_relative 'app/services/states'
require_relative 'app/services/matrixs_operations'