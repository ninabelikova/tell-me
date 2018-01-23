# --- REQUIREMENT ---
require "tell_me/version"
require 'notifier'
require 'chronic'
require 'nickel'
require 'rufus-scheduler'


# --- CLASSES ---

class Message

  def initialize(content, date)
    @content = content
    @date = date
    @scheduler = Rufus::Scheduler.new
  end

  def schedule
    date = @date.strftime "%Y/%m/%d %H:%M"
    @scheduler.at date do
      notify
    end
    @scheduler.join
  end

  def notify
    Notifier.notify(
      title: 'Hey',
      message: @content,
      sound: 'default'
    )
    @scheduler.shutdown
  end

end

# --- FUNCTIONS ---



def parse(command)
  parsed = Nickel.parse(command)
  parsed.message.slice! 'to'
  content = parsed.message
  command.slice! content
  command.slice! 'at'
  date_command = command
  date = Chronic.parse(date_command)
  message = Message.new(content, date)
  message.schedule
end




# --- APP ---

#parse("class in 3 minutes")
