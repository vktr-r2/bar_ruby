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


iteration_two_bar = Bar.new("Iteration Two")
puts iteration_two_bar
iteration_two_bar.bar_system = "Beer", "Whiskey", "Cocktail", "Wine"
puts iteration_two_bar.bar_system