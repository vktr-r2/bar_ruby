# Bar Ruby

### Welcome to Bar Ruby!  Where the drinks are cold, and the code is clean (hopefully).

##### The bar_ruby repo is intended to help me practice OOP and SOLID programming principles.  Feel free to make it your own!

- The Bar needs a Bartender and BarSystem
- The BarSystem stocks BeerKeg and has a pour_beer method
- Bartender needs a BarSystem to pour Beer, and needs a Bar to work in
- Bartender can also make any other Drink that is on the menu.

<em>
Ruby Bar is managed by Hilary  <br/>
======================= <br/>
We serve:<br/>
beer<br/>
whiskey<br/>
cocktail<br/>
wine<br/>
For beer we have:<br/>
Labatts<br/>
Stella<br/>
Le Chouffe<br/>
Canadian<br/>
=======================<br/>
Sorry, we don't sell fries<br/>
Sorry, we don't sell pizza<br/>
Here is your order:<br/>
*Frosty glass of Stella*<br/>
*Delicious looking cocktail*<br/>
=======================<br/>
Man, the local sports team stinks!<br/>
=======================<br/>
*Hilary tidies up*
</em>


##### FEEDBACK/IDEAS/QUESTIONS:

The Bartender class does to much (clean, chat, make_drink etc)?
    - It might be best to have Bartender just handle their job with a generic method like do_thing, and things the bartender does could be their own class?

Bar BarSystem and Bartender are too tightly coupled?
    - Need to better understand what this fully means
    - A better approach would be to depend on abstractions (like interfaces or base classes) so that different types of bartenders or bar systems could be injected without changing the Bar class.  For example, the Bartender could depend on an abstract interface for BarSystem instead of the concrete class.

BarSystem has a custom setter method for the @on_tap instance variable.  But what if I wanted on_tap=() to change?  
    - For example, maybe the caller should tell us whether we want to add the BeerKeg or try remove it.  Maybe we actually WANT two Stella kegs in on_tap because its a popular beer, so we need the caller to pass us a second arg now.
    - How could I have originally implemented this method to allow for this?
    - As it stands now, I'd have to go through my code and find everywhere where on_tap was being called and update it.  Not ideal!
