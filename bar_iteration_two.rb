class Bar
    attr_reader :name, :bar_system, :menu
    attr_accessor :bar_tender

    def initialize(name, bar_tender=nil, bar_system=[])
        @name = name
        @bar_tender = bar_tender
        @bar_system = bar_system
        @menu = {beer: 5, whiskey: 8, cocktail: 8, wine: 8}
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

    # Abstract method that must be implemented in subclasses
    def chat
      raise NotImplementedError, "You must implement the chat method"
    end
  
    # Abstract method that must be implemented in subclasses
    def clean
      raise NotImplementedError, "You must implement the clean method"
    end
end


iteration_two_bar = Bar.new("Iteration Two")
puts iteration_two_bar
iteration_two_bar.bar_system = "Beer", "Whiskey", "Cocktail", "Wine"
puts iteration_two_bar.bar_system