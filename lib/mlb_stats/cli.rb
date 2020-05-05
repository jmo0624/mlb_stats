#require 'pry'
class MlbStats::CLI
  
  def call                       #main call function
    puts "Welcome to MLB Stats!"
    list_stats
    menu
    goodbye
  end
  
  def list_stats            #display the main menu options
    puts "Which stat would you like to see?"
    puts """
      1) League Leaders
      2) Standings
      """
  end
  
  def menu
    puts "Please select the number next to your desired option, type main menu to see the menu again, or type exit:"
    input = nil            
    while input != "exit"    #if user types "exit", the gem will close
      input = gets.strip.downcase   
      case input
      when "1"       #display when user types 1
        league_leader_list
      when "2"         #display when user types 2
        puts "\n"
        MlbStats::Scraper.teams                       #call to Scraper class for teams
      when "main menu"        #returns to main menu
        list_stats
      end
    end
  end
  
  def goodbye          #displays when user types exit
    puts "Thank you for using MLB Stats!"
  end
  
  def league_leader_list         #display the list for league leaders
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
        MlbStats::Scraper.batting_average
      when "2"
        puts "League Leaders in Home Runs:"
        puts "\n"
        MlbStats::Scraper.home_runs
      when "3"
        puts "League Leaders in RBIs:"
        puts "\n"
        MlbStats::Scraper.rbi
      when "4"
        puts "League Leaders in ERA:"
        puts "\n"
        MlbStats::Scraper.era
      when "menu"
        league_leader_list
      when "main menu"
        call
      end
    end
  end
end