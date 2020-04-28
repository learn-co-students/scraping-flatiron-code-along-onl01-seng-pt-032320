require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper

  def get_page
    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end

  def get_courses
    self.get_page.css("article")
  end

  def make_courses
    self.get_courses.each do |course|
      title = course.css('h2').text
      schedule = course.css('.date').text
      description = course.css('p').text
        new_course = Course.new
        new_course.title = title
        new_course.schedule = schedule
        new_course.description = description
    end
  end
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
end



