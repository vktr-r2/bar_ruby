# Bar class stores bar data.  Bar will instantiate a BarSystem and Bartender when instantiated.
class Bar
    attr_accessor :bar_tender, :atmosphere
    attr_reader :name, :menu, :bar_system
    
    def initialize(name, bar_tender)
        @name = name
        @bar_system = BarSystem.new()
        @menu = {beer: 5, whiskey: 8, cocktail: 8, wine: 8}
        @atmosphere = {music: false, television: false}
        @bar_tender = Bartender.new(bar_tender, bar_system, menu)              # Bartender should know what the bar serves and be able to serve it.
    end

    def to_s
        "#{name}"
    end
end

# BarSystem handles which BeerKeg objects are served, and pours the beers.
class BarSystem
    attr_reader :on_tap

    def initialize
        @on_tap = []
    end

    protected

    # Custom setter for on_tap instance variable.
    def on_tap=(beer)
        for keg in on_tap
            if beer == keg.beer_brand
                on_tap.delete(beer)
                return
            end
        end
        on_tap << BeerKeg.new(beer)
    end

    # Instantiates a Beer object and reduces BeerKeg.keg_level value.
    def pour_beer(beer)
        keg = on_tap.find { |keg| keg.beer_brand == beer }
        if keg.keg_level > 0
            keg.keg_level=(keg.keg_level - 1)
            return Beer.new(beer)
        else
            return "*#{beer} keg is empty*"
        end
      end
end

# Bartender manages the bar.  Can pour beer, make drink, take order, clean, chat, recite menu, and update beers served in BarSystem object.
class Bartender
    attr_accessor :chat_topics, :bar_system, :menu
    attr_reader :name
    
    def initialize(name, bar_system, menu)
        @name = name
        @bar_system = bar_system
        @menu = menu
        @chat_topics = {
            1 => "How was your day?",
            2 => "The weather today is crazy, right?",
            3 => "Man, the local sports team stinks!"
        }
    end
    
    def to_s
        "#{name}"
    end
    
    # Randomly puts a chat_topic.
    def chat
        random_key = chat_topics.keys.sample
        puts chat_topics[random_key]
    end
    
    # Checks whether item is served by bar, if true makes order, if false advises customer this isn't served.
    def make_order(*args)
        customer_order = []
        for order_item in args 
            if self.check_order_item(order_item)
                customer_order << make_drink(order_item)
            else
                puts "Sorry, we don't sell #{order_item}"
            end
        end
        sleep(3)
        puts "Here is your order:"
        puts customer_order
    end
    
    def clean
        puts "*#{name} tidies up*"
    end

    # Uses protected on_tap setter method from BarSystem class to update on_tap array.
    def update_beers_on_tap(beer)
        bar_system.send(:on_tap=, beer)
    end

    # Lists menu items served, and beers on tap.
    def recite_menu
        menu_items = menu.keys
        puts "We serve:"
        puts menu_items
        puts "For beer we have:"
        puts bar_system.on_tap
    end

    def learn_new_chat topic(topic)
        chat_topics[chat_topics.keys.max + 1] = topic
    end

    private

    # Takes order_item and checks if it is a key in the menu array, or item in the on_tap array.
    def check_order_item(order_item)
        check_beers = bar_system.on_tap.find { |keg| keg.beer_brand == order_item }
        check_menu = menu.find { |menu_item, price| menu_item == order_item.to_sym }
        check_beers || check_menu
    end
    
    # Instantiates either a Drink or Beer object
    def make_drink(drink)
        if bar_system.on_tap.find { |keg| keg.beer_brand == drink }
            return get_beer(drink)
        end
        Drink.new(drink)
    end
    
    # Uses protected pour_beer method from BarSystem to instantiate a Beer object. 
    def get_beer(beer)
        bar_system.send(:pour_beer, beer)
    end
end

# Stores beer_brand and keg_level
class BeerKeg
    attr_accessor :keg_level
    attr_reader :beer_brand

    def initialize(beer_brand)
        @beer_brand = beer_brand
        @keg_level = 100
    end

    def to_s()
        "#{beer_brand}"
    end
end

class Beer
    attr_reader :beer_brand

    def initialize(beer_brand)
        @beer_brand = beer_brand
    end

    def to_s
        "*Frosty glass of #{beer_brand}*"
    end
end

class Drink
    attr_reader :drink_name

    def initialize(drink_name)
        @drink_name = drink_name
    end
    
    def to_s
        "*Delicious looking #{drink_name}*"
    end
end

=begin
FEATURE SUGGESTIONS:
 - Bartender should ask customer for right amount of money before making order
 - Bartenders should be able to chat about different things, learn diferent topics?
=end

if __FILE__ == $0
    ruby_bar = Bar.new("Ruby Bar", "Viktor")                                    # ooooh a new bar has just opened up

    viktor = ruby_bar.bar_tender                                                
    hilary = Bartender.new("Hilary", ruby_bar.bar_system, ruby_bar.menu)

    ruby_bar.bar_tender=(hilary)                                               # viktor was a lazy bartender so he was fired.  Welcome hilary!

    puts "#{ruby_bar} is managed by #{ruby_bar.bar_tender}"

    puts "======================="

    hilary.update_beers_on_tap("Labatts")                                      # Add Labatts to on_tap
    hilary.update_beers_on_tap("Stella")                                       # Add Stella to on_tap
    hilary.update_beers_on_tap("Le Chouffe")                                   # Add Le Chouffe to on_tap
    hilary.update_beers_on_tap("Labatts")                                      # Remove Labatts from on_tap
    hilary.update_beers_on_tap("Canadian")                                     # Add Canadian

    hilary.recite_menu                                                         # What does the bar serve?

    puts "======================="

    hilary.make_order("Stella", "cocktail", "fries", "pizza")                  # This is my order

    puts "======================="

    hilary.chat                                                                # Hilary likes to chat with the customers 

    puts "======================="

    hilary.clean                                                               # Time to clean the bar before close.
end