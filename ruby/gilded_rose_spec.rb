require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  subject(:gilded_rose) { described_class.new(items) }
  let(:items) { [
    Item.new("foo", 0, 0),
    Item.new("Aged Brie", 2, 0),
    Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
    ] }

  describe "#update_quality" do
    it "does not change the name" do
      gilded_rose.update_quality
      expect(items[0].name).to eq "foo"
    end

    context "Aged Brie" do
      it "increases in Quality the older it gets" do
        gilded_rose.update_quality
        expect(items[1].quality).to eq 1
      end
    end

    context "Sulfuras, Hand of Ragnaros" do
      it "does not decrease in Quality" do
        gilded_rose.update_quality
        expect(items[2].quality).to eq 80
      end
    end
  end
end