# PHASE 2
def convert_to_int(str)
  begin
    Integer(str)

  rescue TypeError, ArgumentError => e

    return nil
  
    
  end
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  else 
    raise StandardError 
  end 
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  puts "Feed me a fruit! (Enter the name of a fruit:)"
  begin
    maybe_fruit = gets.chomp
    reaction(maybe_fruit) 
  rescue
    if maybe_fruit == 'coffee'
      puts 'thx for the coffee, now give me a fruit'
      retry
    end
  end
end  

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    @name = name
    if @name.length < 1
      raise "I can't be besties with someone that doesn't have a name"
    end

    @yrs_known = yrs_known
    if @yrs_known < 5
      raise "I know you for less than 5 years, I'm not your bestie"
    end

    @fav_pastime = fav_pastime
    if @fav_pastime.length < 1
      raise "You're telling me nothing"
    end
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


