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
        for keg in @on_tap
            if beer == keg.beer_brand
                @on_tap.delete(beer)
                return
            end
        end
        @on_tap << BeerKeg.new(beer)
    end

    def pour_beer(beer)
            puts "*Glass of #{beer}*"
    end
end

class BeerKeg
    attr_reader :keg_level, :beer_brand

    def initialize(beer_brand)
        @beer_brand = beer_brand
        @keg_level = 100
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

ruby_bar.bar_system.on_tap=("Labatts")                                    # Add Labatts to on_tap
ruby_bar.bar_system.on_tap=("Stella")                                     # Add Stella to on_tap
ruby_bar.bar_system.on_tap=("Le Chouffe")                                 # Add Le Chouffe to on_tap
ruby_bar.bar_system.on_tap=("Labatts")                                    # Remove Labatts to on_tap

ruby_bar.bar_system.on_tap