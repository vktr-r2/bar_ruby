# Responsible for storing systems that serve the products.
class Bar
    attr_reader :name, :bar_systems, :menu
    attr_accessor :bar_tender

    def initialize(name, bar_systems=[])
        @name = name
        @bar_systems = bar_systems
    end

    def to_s
        "#{name}"
    end

    def bar_systems=(*args)
        args.each do |arg|
          @bar_systems << arg
        end
    end

end

# Responsible for teaching a Bartender what Bar serves (allows Bartender to work at different Bars)
class BarTrainer

    def initialize(bar)
        @bar = bar
    end

    def make_menu
    
    end

    def teach_menu
    
    end

end

# Responsible for basic human functions and data
class Human
    attr_reader :name
    attr_accessor :chat_topics

    def initialize(name)
        @name = name
        @chat_topics = []
    end

    def add_chat_topics(*args)
        args.each do |arg|
            @chat_topics << arg
        end
    end

    def to_s
        "#{name}"
    end

    # Abstract method that must be implemented in subclasses
    def chat
      raise NotImplementedError, "You must implement the chat method"
    end
  
    # Abstract method that must be implemented in subclasses
    def clean
      raise NotImplementedError, "You must implement the clean method"
    end
end

class Bartender < Human

    public
    def learn_bar_menu(BarTrainer)
    
    end

    def take_order(order)

    end

    def serve_order
    
    end

    def chat
        random_chat_topic = chat_topics.sample
        puts random_chat_topic
    end

    def clean
        puts "*Cleans glassware*"
    end

    private
    def check_if_bar_serves_product

    end

    def make_product
    
    end
end

class BarSystem
    attr_accessor :products
    
    def initialize(products=[])
        @products = products
    end

    def add_products(*args)
        for arg in args
            @products << arg unless products.include?(arg)
        end
    end

    def remove_products(*args)
        for arg in args
            @products.delete(arg) if products.include?(arg)
        end
    end

    def make_product(*args)
        raise NotImplementedError, "You must implement the make_product method"
    end
end

class FoodSystem < BarSystem

    def make_product(*args)
        args.each do |arg|
            puts "Here is your #{arg}"
        end
    end
end

class CocktailSystem < BarSystem
    
    def make_product(*args)
        args.each do |arg|
            puts "Here is your #{arg}"
        end
    end
end

class BeerSystem < BarSystem

    def make_product(*args)
        args.each do |arg|
            puts "Here is your #{arg}"
        end
    end
end




iteration_two_bar = Bar.new("Iteration Two")
#puts iteration_two_bar
#iteration_two_bar.bar_system = "Beer", "Whiskey", "Cocktail", "Wine"
#puts iteration_two_bar.bar_system

hilary = Bartender.new("Hilary")
#puts hilary

#hilary.add_chat_topics("How was your day?", "The weather today is crazy, right?", "Politics are a mess!")
#puts hilary.chat_topics
#hilary.clean

#food_system = FoodSystem.new(["Burger", "Fries", "Salad"])
#food_system.add_products("Pizza", "Salad")
#puts "AFTER ADDING PRODUCTS:"
#puts food_system.products
#food_system.remove_products("Sushi", "Salad")
#puts "AFTER REMOVING PRODUCTS:"
#puts food_system.products

#cocktail_system = CocktailSystem.new(["Martini", "Margarita", "Old Fashioned"])

#iteration_two_bar.bar_systems = [food_system, cocktail_system]
#puts iteration_two_bar.bar_systems

beer_system = BeerSystem.new()
beer_system.add_products("Stella", "Coors Light", "Le Chouffe", "Big Wheel")
#puts beer_system.products
beer_system.remove_products("Stella")
#puts beer_system.products
