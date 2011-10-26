#lang: en

Feature: Blog main page and single post page

  Background:
    Given I have configured the blog

  Scenario: Blog main page
    Given I have published a post
     When I visit the blog's main page
     Then I should see the published post

  Scenario: Single post page with published post
    Given I have published a post
     When I visit that post's page
     Then I should see the whole post

  Scenario: Single post page with not published post
    Given I scheduled a post that has not been published yet
     When I visit that post's page
     Then I should get that page doesn't exist error

  Scenario: Single post page unknown post
     When I visit an unknown post's page
     Then I should get that page doesn't exist error

  @pending
  Scenario: Single post page for two posts with the same title
