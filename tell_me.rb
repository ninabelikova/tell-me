# --- REQUIREMENT ---
require 'notifier'
require 'chronic'
require 'nickel'
require 'rufus-scheduler'


# --- CLASSES ---

class Message

  def initialize(content, date)
    @content = content
    @date = date
  end

  def schedule
    scheduler = Rufus::Scheduler.new
    date = @date.strftime "%Y/%m/%d %H:%M"
    scheduler.at date do
      notify(@content)
    end
    scheduler.join
  end

end

# --- FUNCTIONS ---

def notify(message)
  Notifier.notify(
    title: 'Hey',
    message: message,
    sound: 'default'
  )
end

def parse(command)
  parsed = Nickel.parse(command)
  content = parsed.message
  command.slice! content
  command.slice! 'at'
  date_command = command
  date = Chronic.parse(date_command)
  message = Message.new(content, date)
  message.schedule
end




# --- APP ---

parse("class in 3 minutes")
