class Bar

    attr_accessor :bar_tender, :atmosphere
    attr_reader :name, :menu, :bar_system
    
    def initialize(name, bar_tender)
        @name = name
        @bar_tender = bar_tender
        @bar_system = BarSystem.new()
        @menu = {fries: 5, nachos: 12, wings: 12, beer: 5, whiskey: 8, cocktail: 8}
        @atmosphere = {music: false, television: false}
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

class BeerKeg
    attr_reader :keg_level, :beer_brand

    def initialize(beer_brand)
        @beer_brand = beer_brand
        @keg_level = keg_level
    end

    def to_s()
        "#{@beer_brand}"
    end

end

ruby_bar = Bar.new("Ruby", "Viktor")

puts ruby_bar.menu
puts ruby_bar.bar_tender

ruby_bar.bar_tender=("Hilary")                                            # Shift change, Hilary is bar tender now

puts ruby_bar.bar_tender

ruby_bar.bar_system.pour_beer("Any")                                      # Pour a beer - we don't check whether beer exists yet or not.

ruby_bar.bar_system.on_tap=(BeerKeg.new("Labatts"))                       # Add Labatts to on_tap
ruby_bar.bar_system.on_tap=(BeerKeg.new("Stella"))                        # Add Stella to on_tap
ruby_bar.bar_system.on_tap=(BeerKeg.new("Le Chouffe"))                    # Add Le Chouffe to on_tap
ruby_bar.bar_system.on_tap=(BeerKeg.new("Labatts"))                       # Add Labatts to on_tap

ruby_bar.bar_system.on_tap