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
end

class BarSystem
    attr_reader :on_tap

    def initialize
        @on_tap = []
    end

    protected

    def on_tap=(beer)
        for keg in on_tap
            if beer == keg.beer_brand
                on_tap.delete(beer)
                return
            end
        end
        on_tap << BeerKeg.new(beer)
    end

    def pour_beer(beer)
        keg = on_tap.find { |keg| keg.beer_brand == beer }
        if keg.keg_level > 0
            keg.keg_level=(keg.keg_level - 1)
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
    
    def chat
        random_key = chat_topics.keys.sample
        puts chat_topics[random_key]
    end
    
    def make_order(*args)
        order_to_be_made = []
        for order_item in args 
            if self.check_order_item(order_item)
                order_to_be_made << order_item
            else
                puts "We don't sell #{order_item}"
            end
        end
        sleep(2)
        puts "Here is your #{order_to_be_made}"
    end
    
    def clean
        puts "*#{name} tidies up*"
    end

    def update_beers_on_tap(beer)
        bar_system.send(:on_tap=, beer)
    end

    def recite_menu
        menu_items = menu.keys
        puts "We serve:"
        puts menu_items
        puts "For beer we have:"
        puts bar_system.on_tap
    end

    private

    def check_order_item(order_item)
        check_beers = bar_system.on_tap.find { |keg| keg.beer_brand == order_item }
        check_menu = menu.find { |menu_item, price| menu_item == order_item.to_sym }
        check_beers || check_menu
    end
    
    def make_drink(drink)

    end
    
    def get_beer(beer)
        bar_system.send(:pour_beer, beer)
    end
end

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

class Drink
    attr_reader :drink_name

    def initialize(drink_name)
        @drink_name = drink_name
    end
    
    def to_s
        "#{drink_name} *looks delicious*"
    end
end

=begin
# IDEA: Bartender should ask customer for right amount of money before making order
# IDEA: Hilary and Viktor should be able to chat about different things, learn diferent topics?
=end

ruby_bar = Bar.new("Ruby Bar", "Viktor")

viktor = ruby_bar.bar_tender
hilary = Bartender.new("Hilary", ruby_bar.bar_system, ruby_bar.menu)

ruby_bar.bar_tender=(hilary)

puts ruby_bar.bar_tender


hilary.update_beers_on_tap("Labatts")                                      # Add Labatts to on_tap
hilary.update_beers_on_tap("Stella")                                       # Add Stella to on_tap
hilary.update_beers_on_tap("Le Chouffe")                                   # Add Le Chouffe to on_tap
hilary.update_beers_on_tap("Labatts")                                      # Remove Labatts to on_tap
hilary.update_beers_on_tap("Canadian")                                     # Add Canadian

hilary.recite_menu

hilary.make_order("beer", "cocktail", "fries", "pizza")

cocktail = Drink.new("cocktail")
puts cocktail