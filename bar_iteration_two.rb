# Responsible for storing systems that serve the products.
class Bar
    attr_reader :name, :bar_systems, :menu
    attr_accessor :bar_tender

    def initialize(name, bar_systems=[])
        @name = name
        @bar_systems = bar_systems
    end

    public
    def to_s
        "#{name}"
    end

    def bar_systems=(*args)
        @bar_systems.concat(*args)
    end

end

# Responsible for teaching a Bartender what Bar serves (allows Bartender to work at different Bars)
class BarSystemsManager

    attr_reader :bar, :menu

    def initialize(bar)
        @bar = bar
        @bar_systems = bar.bar_systems
        @menu = make_menu(@bar_systems)
    end

    protected
    def teach_menu
        menu
    end

    private
    def make_menu(bar_systems)
        menu = {}
        bar_systems.each do |system|
            menu[system.name] = system.products
        end
        menu
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
    
    public
    def add_chat_topics(*args)
        args.each do |arg|
            @chat_topics << arg
        end
    end

    def to_s
        "#{name}"
    end

    def chat
      raise NotImplementedError, "You must implement the chat method"
    end
  
    def clean
      raise NotImplementedError, "You must implement the clean method"
    end
end

class Bartender < Human

    public
    def train_bartender(bar_trainer)
    
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
    
    def initialize(*args)
        @products = args
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
    attr_reader :name

    def initialize(*args)
        super(*args)
        @name = "Foods"
    end

    def make_product(*args)
        args.each do |arg|
            puts "Here is your #{arg}"
        end
    end
end

class CocktailSystem < BarSystem
    attr_reader :name

    def initialize(*args)
        super(*args)
        @name = "Cocktails"
    end
    
    def make_product(*args)
        args.each do |arg|
            puts "Here is your #{arg}"
        end
    end
end

class BeerSystem < BarSystem
    attr_reader :name

    def initialize(*args)
        super(*args)
        @name = "Beers"
    end

    def make_product(*args)
        args.each do |arg|
            puts "Here is your #{arg}"
        end
    end
end

# Steps
# 1. Instantiate a Bar
iteration_two_bar = Bar.new("Iteration Two")

# 2. Create BarSystems and add products
beers = BeerSystem.new("Coors Light", "Le Chouffe", "Stella")
cocktails = CocktailSystem.new("Old Fashioned", "Margarita", "Martini", "Cesar")
foods = FoodSystem.new("Fries", "Wings", "Nachos")

# 3. Add BarSystems to Bar
iteration_two_bar.bar_systems = cocktails, beers, foods

# 3. Create BarSystemsManager object for this particular bar (creates the menu based on BarSystems installed in the Bar)
bar_system_manager = BarSystemsManager.new(iteration_two_bar)
puts bar_system_manager.menu

# 4. Create Bartender


# 5. Bartender learns the Bar menu


# 6. But what if menu is updated after the fact - when/how should Bartender learn about changes to the menu?