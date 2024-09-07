class Bar

    attr_accessor :bar_tender
    attr_reader :name
    attr_reader :menu
    attr_reader :bar_system
    
    def initialize(name, bar_tender)
        @name = name
        @bar_tender = bar_tender
        @bar_system = BarSystem.new(["Le Chouffe", "Stella", "Blue Moon", "Canadian"])
        @menu = {fries: 5, nachos: 12, wings: 12, beer: 5, whiskey: 8, cocktail: 8}
    end

=begin
SHOULD THIS BE IN BAR?  SHOUD BarTender maybe set_atmosphere, and bar should store state of music and tv as bools?
    def set_atmosphere(music, television)
        if music:
            
        end

        if television:

    end
=end
end

class BarSystem
    attr_reader :on_tap

    def initialize(on_tap)
        @on_tap = on_tap
    end

    def on_tap=(beer)
        if @on_tap.include?(beer)
            @on_tap.delete(beer)
        else
            @on_tap << beer
        end
    end

    def pour_beer(beer)
            puts "*Glass of #{beer}*"
    end
end


ruby_bar = Bar.new("Ruby", "Viktor")

puts ruby_bar.menu
puts ruby_bar.bar_tender

ruby_bar.bar_tender=("Hilary")                  # Shift change, Hilary is bar tender now

puts ruby_bar.bar_tender
puts ruby_bar.bar_system.on_tap

ruby_bar.bar_system.pour_beer("Any")            # Pour a beer - we don't check whether beer exists yet or not.

ruby_bar.bar_system.on_tap=("Labatts")          # Add Labatts to on_tap
ruby_bar.bar_system.on_tap=("Stella")           # Remove Stells from on_tap
puts ruby_bar.bar_system.on_tap


