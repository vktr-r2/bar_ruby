class Bar
    attr_reader :name, :bar_system, :menu
    attr_accessor :bar_tender

    def initialize(name, bar_tender=nil, bar_system=[])
        @name = name
        @bar_tender = bar_tender
        @bar_system = bar_system
    end

    def to_s
        "#{name}"
    end

    def bar_system=(*args)
        args.each do |arg|
          @bar_system << arg
        end
    end

end

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
    attr_reader :name

    def initialize(name)
        super(name)
    end

    def chat
        random_chat_topic = chat_topics.sample
        puts random_chat_topic
    end

    def clean
        puts "*Cleans glassware*"
    end
end

class BarSystem
    attr_accessor :products
    
    def initialize(products)
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

class LiquorSystem < BarSystem
    
    def make_product(*args)
        args.each do |arg|
            puts "Here is your #{arg}"
        end
    end
end

#iteration_two_bar = Bar.new("Iteration Two")
#puts iteration_two_bar
#iteration_two_bar.bar_system = "Beer", "Whiskey", "Cocktail", "Wine"
#puts iteration_two_bar.bar_system

#hilary = Bartender.new("Hilary")
#puts hilary

#hilary.add_chat_topics("How was your day?", "The weather today is crazy, right?", "Politics are a mess!")
#puts hilary.chat_topics
#hilary.clean





iteration_two_bar = Bar.new("Iteration Two")
#puts iteration_two_bar
#iteration_two_bar.bar_system = "Beer", "Whiskey", "Cocktail", "Wine"
#puts iteration_two_bar.bar_system

#hilary = Bartender.new("Hilary")
#puts hilary

#hilary.add_chat_topics("How was your day?", "The weather today is crazy, right?", "Politics are a mess!")
#puts hilary.chat_topics
#hilary.clean

food_system = FoodSystem.new(["Burger", "Fries", "Salad"])
food_system.add_products("Pizza", "Salad")
puts "AFTER ADDING PRODUCTS:"
puts food_system.products
food_system.remove_products("Sushi", "Salad")
puts "AFTER REMOVING PRODUCTS:"
puts food_system.products
