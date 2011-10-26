#lang: en

Feature: The post file format

  The post file format is simple.

  You only have to take care of the markup you want to use and respect
  a simple rule: write things in order.

  The only thing you need to know is that the file will be splitted into four parts:

    - Publication time
    - Title
    - Description
    - Content

  The first line with text in the file will be parsed as the publication time
  of the post. It will handle any format that DateTime#parse would. Remember
  that if no timezone is specfied all times will be in GMT+00:00.

  The second line with text in the file will be taken as the post title.
  It should be short and contain no markup.

  The third line with text will be taken as the post description. It should
  also be short, usually up to 160 characters. You can not use markup in the
  post description.

  The rest of the file will be taken as the post content. You can use HAML
  in it and make it as long as you want it to be.

  Scenario: A correctly formatted post
    Given a file with the content:
      """
      2011-01-01 11:00:00+02:00
      The post title.
      The post description.
      The first line of the post content.
      The second line of the post content.
      """
    When a post is created from that file
    Then it should be published on "2011-01-01 11:00:00+02:00"
     And the title should be "The post title."
     And the description should be "The post description."
     And the content should contain "The first line of the post content."
     And the content should contain "The second line of the post content."

  Scenario: An empty post
    Given a file with the content:
      """
      """
    When a post is created from that file
    Then the post should not be published

  @pending
  Scenario: A post with missing parts

  @pending
  Scenario: A post with a malformed publication time
