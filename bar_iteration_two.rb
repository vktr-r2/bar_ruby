# Responsible for storing systems that serve the products.
class Bar
  attr_reader :name, :bar_systems, :menu
  attr_accessor :bar_tender

  def initialize(name, bar_systems = [])
    @name = name
    @bar_systems = bar_systems
  end

  def to_s
    "#{name}"
  end

  def bar_systems=(*args)
    @bar_systems.concat(*args)
  end
end

# Responsible for teaching a Bartender what Bar serves (allows Bartender to work at different Bars)
class MenuManager
  attr_reader :bar, :menu

  def initialize(bar)
    @bar = bar
    @bar_systems = bar.bar_systems
    @menu = make_menu(@bar_systems)
  end

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

  def add_chat_topics(*args)
    args.each do |arg|
      @chat_topics << arg
    end
  end

  def to_s
    "#{name}"
  end

  def chat
    raise NotImplementedError, 'You must implement the chat method'
  end

  def clean
    raise NotImplementedError, 'You must implement the clean method'
  end
end

class Bartender < Human
  attr_reader :current_bar_menu

  def initialize(name, chat_topics = [])
    super(name)
    super(chat_topics)
    @current_bar_menu = {}
  end

  def order(*args)
    check_if_bar_serves_product(args)
  end

  def chat
    random_chat_topic = chat_topics.sample
    puts random_chat_topic
  end

  def clean
    puts '*Cleans glassware*'
  end

  def set_current_bar_menu(menu_manager)
    @current_bar_menu = learn_menu(menu_manager)
  end

  private

  def check_if_bar_serves_product(*args)
    available_order = []
    args.each do |item|
      menu.each do |_category, items|
        if items.include?(item)
          available_order << item
        else
          puts "We don't serve #{item}"
        end
      end
    end
    available_order
  end

  def make_product; end

  def serve_order; end

  def learn_menu(menu_manager)
    menu_manager.teach_menu
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
    raise NotImplementedError, 'You must implement the make_product method'
  end
end

class FoodSystem < BarSystem
  attr_reader :name

  def initialize(*args)
    super(*args)
    @name = 'Foods'
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
    @name = 'Cocktails'
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
    @name = 'Beers'
  end

  def make_product(*args)
    args.each do |arg|
      puts "Here is your #{arg}"
    end
  end
end

# Steps
# 1. Instantiate a Bar
iteration_two_bar = Bar.new('Iteration Two')

# 2. Create BarSystems and add products
beers = BeerSystem.new('Coors Light', 'Le Chouffe', 'Stella')
cocktails = CocktailSystem.new('Old Fashioned', 'Margarita', 'Martini', 'Cesar')
foods = FoodSystem.new('Fries', 'Wings', 'Nachos')

# 3. Add BarSystems to Bar
iteration_two_bar.bar_systems = cocktails, beers, foods

# 3. Create MenuManager object for this particular bar (creates the menu based on BarSystems installed in the Bar)
menu_manager = MenuManager.new(iteration_two_bar)
puts menu_manager.menu

# 4. Create Bartender
hilary = Bartender.new('Hilary')
# puts hilary

# 5. Bartender learns the Bar menu
# puts hilary.current_bar_menu
hilary.set_current_bar_menu(menu_manager)
# puts hilary.current_bar_menu

# 6. Bartender is now able to take an order
hilary.order
