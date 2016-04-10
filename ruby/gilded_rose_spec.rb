require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  subject(:gilded_rose) { described_class.new(items) }
  let(:items) { [
    Item.new("foo", 0, 0),
    Item.new("foo", 0, 4),
    Item.new("Aged Brie", 2, 0),
    Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
    Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
    Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 50),
    Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 20),
    Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 20),
    Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 20)
    ] }

  describe "#update_quality" do
    it "does not change the name" do
      gilded_rose.update_quality
      expect(items[0].name).to eq "foo"
    end

    it "decreases the sell_in value by 1" do
      gilded_rose.update_quality
      expect(items[0].sell_in).to eq -1
    end

    it "quality of an item is never negative" do
      gilded_rose.update_quality
      expect(items[0].quality).to eq 0
    end

    it "quality degrades twice as fast once the sell by date has passed" do
      gilded_rose.update_quality
      expect(items[1].quality).to eq 2
    end

    context "Aged Brie" do
      it "increases in quality the older it gets" do
        gilded_rose.update_quality
        expect(items[2].quality).to eq 1
      end
    end

    context "Sulfuras, Hand of Ragnaros" do
      it "does not decrease in quality" do
        gilded_rose.update_quality
        expect(items[3].quality).to eq 80
      end
    end

    context "Backstage passes to a TAFKAL80ETC concert" do
      it "increases in quality as its sell_in value approaches" do
        gilded_rose.update_quality
        expect(items[4].quality).to eq 21
      end

      it "quality of an item is never more than 50" do
        gilded_rose.update_quality
        expect(items[5].quality).to eq 50
      end

      context "when there are 10 days or less sell_in value" do
        it "increases in quality by 2" do
          gilded_rose.update_quality
          expect(items[6].quality).to eq 22
        end
      end

      context "when there are 5 days or less sell_in value" do
        it "increases in quality by 3" do
          gilded_rose.update_quality
          expect(items[7].quality).to eq 23
        end
      end

      context "after the concert" do
        it "quality drops to 0" do
          gilded_rose.update_quality
          expect(items[8].quality).to eq 0
        end
      end
    end
  end
end