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