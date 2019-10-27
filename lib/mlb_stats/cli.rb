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
      1) League Leaders
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
        league_leader_list
      when "2"
        puts "\n"
        puts MlbStats::Scraper.teams.each.with_index(1).to_a
        
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
  
  def league_leader_list
    puts "Which stat would you like to see the league leaders for?"
    puts """
      1) Batting Average
      2) Home Runs
      3) Runs Batted In
      4) Earned Run Average
      """
      league_leader_menu
  end
  
  def league_leader_menu
    puts "Please select the number next to your desired option, type list to see the menu again, or type exit:"
    input = nil
    while input != "exit"
      input = gets.strip.downcase
      case input
      when "1"
        puts "League Leaders in Batting Average:"
        puts "\n"
        puts MlbStats::Scraper.batting_average.each.with_index(1).to_a
      when "2"
        puts "League Leaders in Home Runs:"
        puts "\n"
        puts MlbStats::Scraper.home_runs.each.with_index(1).to_a
      when "3"
        puts "League Leaders in RBIs:"
        puts "\n"
        puts MlbStats::Scraper.rbi.each.with_index(1).to_a
      when "4"
        puts "League Leaders in ERA:"
        puts "\n"
        puts MlbStats::Scraper.era.each.with_index(1).to_a
      when "menu"
        league_leader_list
      when "main menu"
        call
      end
    end
  end
end