require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  subject(:gilded_rose) { described_class.new(items) }
  let(:items) { [
    Item.new("foo", 0, 0),
    Item.new("Aged Brie", 2, 0),
    Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
    Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
    Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 20),
    Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 20),
    Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 20)
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

    context "Backstage passes to a TAFKAL80ETC concert" do
      it "increases in Quality as its SellIn value approaches" do
        gilded_rose.update_quality
        expect(items[3].quality).to eq 21
      end

      context "when there are 10 days or less SellIn value" do
        it "increases in Quality by 2" do
          gilded_rose.update_quality
          expect(items[4].quality).to eq 22
        end
      end

      context "when there are 5 days or less SellIn value" do
        it "increases in Quality by 3" do
          gilded_rose.update_quality
          expect(items[5].quality).to eq 23
        end
      end

      context "after the concert" do
        it "Quality drops to 0" do
          gilded_rose.update_quality
          expect(items[6].quality).to eq 0
        end
      end
    end
  end
end