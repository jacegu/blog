require 'mog'

shared_examples_for "when there are no posts" do
  context "when there are no posts" do
    let(:post_dir_path) { "spec/fixtures/empty" }

    it "returns an empty result" do
      expect(blog.list_posts).to be_empty
    end
  end
end


RSpec.describe "A Mog blog" do
  let(:blog) { Mog.blog(post_repository: post_repository) }
  let(:post_repository) { Mog.post_repository(post_dir_path: post_dir_path) }

  describe "Listing all posts" do
    let(:post_dir_path) { "spec/fixtures" }

    it "returns all the existing posts" do
      posts = blog.list_posts

      expect(posts).to match_array([
        Mog::Post.new({
          title: "post title",
          lang: "en",
          date: "2015-05-01",
          description: "post description",
          content: "post content 1\npost content 2\n\n- item1\n- item2\n"
        })
      ])
    end

    include_examples "when there are no posts"
  end

end
