require 'pry'
class MlbStats::CLI
  
  def call
    puts "Welcome to MLB Stats!"
    list_stats
    menu
    goodbye
  end
  
  def list_stats
    puts "Which stat would you like to see?"
    puts """
      1) Schedule
      2) Standings
      3) Teams
      """
  end
  
  def menu
    puts "Please select the number next to your desired option, type list to see the menu again, or type exit:"
    input = nil
    while input != "exit"
      input = gets.strip.downcase
      case input
      when "1"
        puts "more info on schedule"
      when "2"
        puts MlbStats::Scraper.teams
        
       # binding.pry
      when "3"
        puts "more info on teams"
      when "list"
        list_stats
      end
    end
  end
  
  def goodbye
    puts "Thank you for using MLB Stats!"
  end
end