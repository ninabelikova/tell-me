require 'notifier'

input_array = ARGV

def notify(message)
  Notifier.notify(
    title: 'Hey',
    message: message,
    sound: 'default'
  )
end

notify(input_array[0])
