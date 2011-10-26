Given /^I have configured the blog$/ do
  post_dir = PostDir.at(TEMPORAL_DIR)
  Blog.load_posts_from(post_dir)
end

Given /^I have published a post$/ do
  content = a_post_file_with(SAMPLE_PUBLICATION_DATE, SAMPLE_TITLE,
                             SAMPLE_DESCRIPTION, SAMPLE_CONTENT)
  create_post_file_with(content)
end

Given /^I scheduled a post that has not been published yet$/ do
  content = a_post_file_with('9999-12-31 23:59:59+02:00',
                             SAMPLE_TITLE,
                             SAMPLE_DESCRIPTION,
                             SAMPLE_CONTENT)
  create_post_file_with(content)
end


When /^I visit the blog's main page$/ do
  visit '/blog'
end

When /^I visit that post's page$/ do
  visit '/blog/title'
end

When /^I visit an unknown post's page$/ do
  visit '/blog/the-unknown-post-that-does-not-exist'
end


Then /^I should see the published post$/ do
  page.should have_css '.post .title', text: SAMPLE_TITLE, href: %r{/blog/title}
  page.should have_css '.post .description', text: SAMPLE_DESCRIPTION
end

Then /^I should see the whole post$/ do
  page.should have_content SAMPLE_TITLE
  page.should have_content SAMPLE_DESCRIPTION
  page.should have_content SAMPLE_CONTENT
end

Then /^I should get that page doesn't exist error$/ do
  page.driver.response.status.should == 404
  page.should have_content('404')
end
