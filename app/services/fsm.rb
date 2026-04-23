module FSM
  def self.storage
    @storage ||= {}
  end

  def self.set(user_id, state)
    storage[user_id] ||= {}
    storage[user_id][:state] = state
  end

  def self.get(user_id)
    storage[user_id] && storage[user_id][:state]
  end

  def self.set_data(user_id, key, value)
    storage[user_id] ||= {}
    storage[user_id][:data] ||= {}
    storage[user_id][:data][key] = value
  end

  def self.get_data(user_id, key)
    storage[user_id] &&
      storage[user_id][:data] &&
      storage[user_id][:data][key]
  end

  def self.clear(user_id)
    storage.delete(user_id)
  end
end