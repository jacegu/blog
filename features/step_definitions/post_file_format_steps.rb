Given /^a file with the content:$/ do |content|
  create_post_file_with(content)
end

When /^a post is created from that file$/ do
  File.open(@file_path, 'r+'){ |f| @post = PostFile.from(f) }
end

Then /^it should be published on "([^"]*)"$/ do |date_and_time|
  expected_publication_time = DateTime.parse(date_and_time)
  @post.publication_time.should == expected_publication_time
end

Then /^the title should be "([^"]*)"$/ do |expected_title|
  @post.title.should == expected_title
end

Then /^the description should be "([^"]*)"$/ do |expected_description|
  @post.description.should == expected_description
end

Then /^the content should contain "([^"]*)"$/ do |expected_content|
  @post.content.should match(expected_content)
end

Then /^the post should not be published$/ do
  @post.published?.should be_false
end
