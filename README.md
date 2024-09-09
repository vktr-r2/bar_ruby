Welcome to Bar Ruby!  Where the drinks are cold, and the code is clean.

The bar_ruby repo is intended to help me practice OOP and SOLID programming principles.  Feel free to make it your own!




PROPOSED ARCHITECTURE NOTES
 
Bar
    self.bar_system = BarSystem
    self.bar_tender = BarTender
    self.menu = Dict/Hash


BarSystem
    self.beers_on_tap = List[BeerKeg]
    
    pour_beer


BeerKeg
    self.beer_brand = String
    self.keg_level = Int

    show_keg_level


BarTender
    self.name = String

    chat
    make_drink
    clean


Drink(Superclass) #OR should Drink be a module??
    self.name = String

    look_delicious


Beer(Drink)

    bubble


Whiskey(Drink)
    self.ice_cubes


Cocktail(Drink)
    self.ingredients



Questions for Roms:

1. I ran into some design troubles when I tried to implement how a Bartender object could check to see if the order is something that the bar can serve.  What is the best way to proceed?  The Bar stores the menu data, and also stores which Bartender object is currently working. 