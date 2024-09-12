# spec/bar_spec.rb
require "rspec"
require_relative "../main"

RSpec.describe Bar do
  let(:bar) { Bar.new("Ruby Bar", "Viktor") }
  let(:bartender) { bar.bar_tender }

  describe "#initialize" do
    it "creates a bar with a name, a menu, atmosphere, and a bartender" do
      expect(bar.name).to eq("Ruby Bar")
      expect(bar.bar_tender.name).to eq("Viktor")
      expect(bar.menu).to include(:beer, :whiskey, :cocktail, :wine)
      expect(bar.atmosphere).to eq({music: false, television: false})
    end
  end

  describe "#to_s" do
    it "returns the name of the bar" do
      expect(bar.to_s).to eq("Ruby Bar")
    end
  end
end

RSpec.describe BarSystem do
  let(:bar_system) { BarSystem.new }

  describe "#initialize" do
    it "initializes with an empty on_tap array" do
      expect(bar_system.on_tap).to eq([])
    end
  end

  describe "#update_beers_on_tap" do
    it "adds a new beer to the on_tap array" do
      bartender = Bartender.new("Viktor", bar_system, {})
      bartender.update_beers_on_tap("Stella")
      expect(bar_system.on_tap.map(&:beer_brand)).to include("Stella")
    end
  end

  describe "#pour_beer" do
    it "pours a beer and reduces the keg level" do
      bartender = Bartender.new("Viktor", bar_system, {})
      bartender.update_beers_on_tap("Stella")
      beer = bartender.send(:get_beer, "Stella")
      expect(beer).to be_a(Beer)
      expect(beer.to_s).to eq("*Frosty glass of Stella*")
      keg = bar_system.on_tap.find { |k| k.beer_brand == "Stella" }
      expect(keg.keg_level).to eq(99)
    end

    it "returns an empty keg message if beer is out" do
      bartender = Bartender.new("Viktor", bar_system, {})
      bartender.update_beers_on_tap("Stella")
      keg = bar_system.on_tap.find { |k| k.beer_brand == "Stella" }
      keg.keg_level = 0
      result = bartender.send(:get_beer, "Stella")
      expect(result).to eq("*Stella keg is empty*")
    end
  end
end

RSpec.describe Bartender do
  let(:bar) { Bar.new("Ruby Bar", "Viktor") }
  let(:bartender) { bar.bar_tender }

  describe "#initialize" do
    it "initializes with a name, bar system, and menu" do
      expect(bartender.name).to eq("Viktor")
      expect(bartender.bar_system).to be_a(BarSystem)
      expect(bartender.menu).to include(:beer, :whiskey, :cocktail, :wine)
    end
  end

  describe "#chat" do
    it "outputs a random chat topic" do
      expect { bartender.chat }.to output(/How was your day?|The weather today is crazy, right?|Man, the local sports team stinks!/).to_stdout
    end
  end

  describe "#make_order" do
    before do
      bartender.update_beers_on_tap("Stella")
    end

    it "makes an order for an available drink" do
      expect { bartender.make_order("Stella") }.to output(/Here is your order:/).to_stdout
    end

    it "informs customer if item is not available" do
      expect { bartender.make_order("Margarita") }.to output(/Sorry, we don't sell Margarita/).to_stdout
    end
  end

  describe "#update_beers_on_tap" do
    it "updates the beers on tap" do
      bartender.update_beers_on_tap("Le Chouffe")
      expect(bartender.bar_system.on_tap.map(&:beer_brand)).to include("Le Chouffe")
    end
  end

  describe "#recite_menu" do
    it "lists menu items and beers on tap" do
      bartender.update_beers_on_tap("Stella")
      expect { bartender.recite_menu }.to output(/We serve:\nbeer\nwhiskey\ncocktail\nwine\nFor beer we have:/).to_stdout
    end
  end
end

RSpec.describe BeerKeg do
  let(:beer_keg) { BeerKeg.new("Stella") }

  describe '#initialize' do
    it 'creates a beer keg with a beer brand and keg level' do
      expect(beer_keg.beer_brand).to eq("Stella")
      expect(beer_keg.keg_level).to eq(100)
    end
  end
end

RSpec.describe Beer do
  let(:beer) { Beer.new("Stella") }

  describe '#initialize' do
    it 'creates a Beer object with a beer brand' do
      expect(beer.beer_brand).to eq("Stella")
    end

    it 'returns a string representation of the beer' do
      expect(beer.to_s).to eq("*Frosty glass of Stella*")
    end
  end
end