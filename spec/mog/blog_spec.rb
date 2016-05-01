require 'mog'

shared_examples_for "when there are no posts" do
  context "when there are no posts" do
    let(:post_dir_path) { "spec/fixtures/empty" }

    it "returns an empty result" do
      expect(posts).to be_empty
    end
  end
end

RSpec.describe "A Mog blog" do
  let(:blog) { Mog.blog(post_repository: post_repository) }
  let(:post_repository) { Mog.post_repository(post_dir_path: post_dir_path) }
  let(:post_dir_path) { "spec/fixtures" }

  describe "Listing all posts" do
    let(:posts) { blog.list_all_posts }

    it "returns all the existing posts" do
      expect(posts).to match_array([
        Mog::Post.new({
          title: "post title",
          lang: "en",
          date: "2015-05-01",
          description: "post description",
          content: "post content 1\npost content 2\n\n- item1\n- item2\n"
        }),
        Mog::Post.new({
          title: "post b",
          lang: "en",
          date: "2015-04-11",
          description: "another post example",
          content: "foo bar baz\n"
        }),
        Mog::Post.new({
          title: "post a",
          lang: "es",
          date: "2015-04-11",
          description: "yet another post example",
          content: "lorem ipsum.\n"
        }),
        Mog::Post.new({
          title: "a future post",
          lang: "en",
          date: "2100-01-01",
          description: "a future post description",
          content: "a future post content\n"
        }),
      ])
    end

    include_examples "when there are no posts"
  end

  describe "Listing all posts by date" do
    let(:posts) { blog.list_published_posts }

   it "returns all the published posts ordered by date" do
      expect(posts.count).to eq(3)
      expect(posts[0].title).to eq("post title")
      expect(posts[0].date).to eq("2015-05-01")
      expect(posts[1].title).to eq("post a")
      expect(posts[1].date).to eq("2015-04-11")
      expect(posts[2].title).to eq("post b")
      expect(posts[2].date).to eq("2015-04-11")
    end

    include_examples "when there are no posts"
  end

end
