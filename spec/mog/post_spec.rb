require 'mog'

RSpec.describe Mog::Post do

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
