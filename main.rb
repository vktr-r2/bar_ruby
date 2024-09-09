class Bar
    attr_accessor :bar_tender, :atmosphere
    attr_reader :name, :menu, :bar_system
    
    def initialize(name, bar_tender)
        @name = name
        @bar_system = BarSystem.new()
        @menu = {beer: 5, whiskey: 8, cocktail: 8, wine: 8}
        @atmosphere = {music: false, television: false}
        @bar_tender = Bartender.new(bar_tender, @bar_system, @menu)              # Bartender should know what the bar serves and be able to serve it.
    end
end

class BarSystem

    def initialize
        @on_tap = []
    end

    def on_tap
        for keg in @on_tap
            puts keg
        end
    end

    def on_tap=(beer)
        for keg in @on_tap
            if beer == keg.beer_brand
                @on_tap.delete(beer)
                return
            end
        end
        @on_tap << BeerKeg.new(beer)
    end

    def pour_beer(beer)
        keg = @on_tap.find { |keg| keg.beer_brand == beer }
        
        if keg.nil?
          return "*No #{beer} on tap*"
        elsif keg.keg_level > 0
          keg.keg_level -= 1
          return "*Glass of #{beer}*"
        else
          return "*#{beer} keg is empty*"
        end
      end
end


class Bartender
    attr_accessor :chat_topics, :bar_system, :menu
    attr_reader :name
    
    def initialize(name, bar_system, menu)
        @name = name
        @bar_system = bar_system
        @chat_topics = {
            1 => "How was your day?",
            2 => "The weather today is crazy, right?",
            3 => "Man, the local sports team stinks!"
        }
    end
    
    def to_s
        "#{@name}"
    end
    
    def chat
        random_key = @chat_topics.keys.sample
        puts @chat_topics[random_key]
    end
    
    def make_order(order)
        sleep(2)
        puts "Here is your #{order}"
    end
    
    def clean
        puts "*#{@name} tidies up*"
    end
    
    def check_menu(order)
        
    end
    
    def get_drink(drink)

    end
    
    def get_beer(beer)
        return bar_system.pour_beer(beer)
    end
end

class BeerKeg
    attr_reader :keg_level, :beer_brand

    def initialize(beer_brand)
        @beer_brand = beer_brand
        @keg_level = 100
    end

    def to_s()
        "#{@beer_brand}"
    end

end


=begin
ruby_bar = Bar.new("Ruby", "Viktor")

viktor = ruby_bar.bar_tender

puts ruby_bar.menu
puts ruby_bar.bar_tender

hilary = Bartender.new("Hilary")
ruby_bar.bar_tender=(hilary)                                                # Shift change, Hilary is bar tender now

puts ruby_bar.bar_tender

ruby_bar.bar_system.on_tap=("Labatts")                                      # Add Labatts to on_tap
ruby_bar.bar_system.on_tap=("Stella")                                       # Add Stella to on_tap
ruby_bar.bar_system.on_tap=("Le Chouffe")                                   # Add Le Chouffe to on_tap
ruby_bar.bar_system.on_tap=("Labatts")                                      # Remove Labatts to on_tap
ruby_bar.bar_system.on_tap

ruby_bar.bar_system.pour_beer("Any")                                        # Pour a beer - we don't check whether beer exists yet or not.

puts hilary
puts hilary.class

hilary.clean                                                                # Bartender can clean
hilary.chat                                                                 # Bartender can chat
hilary.make_order("pizza")                                                  # Bartender can make order - we still don't check whether order eixsts yet or not

ruby_bar.bar_tender=(viktor)                                                # Viktor is back on shift now
puts ruby_bar.bar_tender
=end

=begin
# IDEA: Bartender should ask customer for right amount of money before making order
# IDEA: Hilary and Viktor should be able to chat about different things, learn diferent topics?
=end

ruby_bar = Bar.new("Ruby Bar", "Viktor")

viktor = ruby_bar.bar_tender
hilary = Bartender.new("Hilary", ruby_bar.bar_system, ruby_bar.menu)

puts viktor.class
puts hilary.class

ruby_bar.bar_tender=(hilary)

puts ruby_bar.bar_tender

puts hilary.get_beer("Stella")