# spec/bar_spec.rb
require 'rspec'
require_relative '../main'

RSpec.describe Bar do
  let(:bar) { Bar.new("Ruby Bar", "Viktor") }
  let(:bartender) { bar.bar_tender }

  describe '#initialize' do
    it 'creates a bar with a name, a menu, atmosphere, and a bartender' do
      expect(bar.name).to eq("Ruby Bar")
      expect(bar.bar_tender.name).to eq("Viktor")
      expect(bar.menu).to include(:beer, :whiskey, :cocktail, :wine)
      expect(bar.atmosphere).to eq({music: false, television: false})
    end
  end

  describe '#to_s' do
    it 'returns the name of the bar' do
      expect(bar.to_s).to eq("Ruby Bar")
    end
  end
end

RSpec.describe BarSystem do
  let(:bar_system) { BarSystem.new }

  describe '#initialize' do
    it 'initializes with an empty on_tap array' do
      expect(bar_system.on_tap).to eq([])
    end
  end

  describe '#update_beers_on_tap' do
    it 'adds a new beer to the on_tap array' do
      bartender = Bartender.new("Viktor", bar_system, {})
      bartender.update_beers_on_tap("Stella")
      expect(bar_system.on_tap.map(&:beer_brand)).to include("Stella")
    end
  end

  describe '#pour_beer' do
    it 'pours a beer and reduces the keg level' do
      bartender = Bartender.new("Viktor", bar_system, {})
      bartender.update_beers_on_tap("Stella")
      beer = bartender.send(:get_beer, "Stella")
      expect(beer).to be_a(Beer)
      expect(beer.to_s).to eq("*Frosty glass of Stella*")
      keg = bar_system.on_tap.find { |k| k.beer_brand == "Stella" }
      expect(keg.keg_level).to eq(99)
    end

    it 'returns an empty keg message if beer is out' do
      bartender = Bartender.new("Viktor", bar_system, {})
      bartender.update_beers_on_tap("Stella")
      keg = bar_system.on_tap.find { |k| k.beer_brand == "Stella" }
      keg.keg_level = 0
      result = bartender.send(:get_beer, "Stella")
      expect(result).to eq("*Stella keg is empty*")
    end
  end
end
