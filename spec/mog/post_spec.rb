require 'mog'

RSpec.describe Mog::Post do

  describe "parsing dates" do
    it "handles no dates" do
      post = described_class.new
      expect(post.date).to be_nil
    end

    it "handles String dates" do
      post = described_class.new(date: "2011-01-31")
      expect(post.date).to eq(Date.parse("2011-01-31"))
    end

    it "handles Date dates" do
      date = Date.new(2015, 12, 15)
      post = described_class.new(date: date)
      expect(post.date).to eq(date)
    end
  end

  describe "#slug" do
    it "returns the post title in lowercase" do
      post = described_class.new(title: "TiTLe")
      expect(post.slug).to eq("title")
    end

    it "replaces the spaces in the title with hyphens" do
      post = described_class.new(title: "a title with spaces")
      expect(post.slug).to eq("a-title-with-spaces")
    end

    it "replaces tabs in the title with hyphens" do
      post = described_class.new(title: "a title with tabs")
      expect(post.slug).to eq("a-title-with-tabs")
    end

    it "removes non alphanumeric characters" do
      post = described_class.new(title: %q{&t.h·3,/ \"p¡0!s(t) -[/t$1%t&l3?})
      expect(post.slug).to eq("th3-p0st-t1tl3")
    end

    it "removes underscores" do
      post = described_class.new(title: "a_ title_ with_ underscores_")
      expect(post.slug).to eq("a-title-with-underscores")
    end
  end

end
