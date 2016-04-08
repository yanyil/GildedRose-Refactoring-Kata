require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  subject(:gilded_rose) { described_class.new(items) }
  let(:items) { [
    Item.new("foo", 0, 0),
    Item.new("Aged Brie", 2, 0)
    ] }

  describe "#update_quality" do
    it "does not change the name" do
      gilded_rose.update_quality()
      expect(items[0].name).to eq "foo"
    end

    context "Aged Brie" do
      it "increases in Quality the older it gets" do
        gilded_rose.update_quality()
        expect(items[1].quality).to eq 1
      end
    end
  end
end