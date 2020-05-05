class MlbStats::Scraper
  
  def self.get_page(input)         #set doc to different webpage depending on the user input
    if input == "standings"
      @doc = Nokogiri::HTML(open("http://www.espn.com/mlb/standings/_/group/overall"))
    elsif input == "batting average"
      @doc = Nokogiri::HTML(open("http://www.espn.com/mlb/stats/batting/_/year/2019/seasontype/2"))
    elsif input == "home runs"
      @doc = Nokogiri::HTML(open("http://www.espn.com/mlb/stats/batting/_/seasontype/2/sort/homeRuns"))
    elsif input == "runs batted in"
      @doc = Nokogiri::HTML(open("http://www.espn.com/mlb/stats/batting/_/seasontype/2/sort/RBIs/order/true"))
    elsif input == "earned run average"
      @doc = Nokogiri::HTML(open("http://www.espn.com/mlb/stats/pitching/_/seasontype/2/order/false"))
    end

  end
  
  def self.stats
    stats = {}
    stats[:standings] = self.get_teams(get_page("standings"))
    stats[:batting_average] = self.get_stats(get_page("batting average"))
    stats[:home_runs] = self.get_stats(get_page("home runs"))
    stats[:rbi] = self.get_stats(get_page("runs batted in"))
    stats[:era] = self.get_stats(get_page("earned run average"))
    stats
  end
  
  def self.teams          #iterate through the teams and list them in order
    index = 0
    MlbStats::Teams.all.clear
    stats[:standings].each do |team|
      MlbStats::Teams.new(team)
      puts " #{index + 1}. #{team}"       #displays the list number nect to the stat
      index += 1
    end
  end
  
  def self.batting_average
    index = 0
    MlbStats::LeagueLeaders.all.clear
    stats[:batting_average].each_slice(2) do |player, stat_amount|    #display the player name                                                                     and stat amount on the                                                                       same line
      MlbStats::LeagueLeaders.new(player, stat_amount)
    
    puts "#{index + 1}. #{player}..........  #{stat_amount}"
    index += 1
    end
    
  end
  
  def self.home_runs
    index = 0
    MlbStats::LeagueLeaders.all.clear
    stats[:home_runs].each_slice(2) do |player, stat_amount|
      MlbStats::LeagueLeaders.new(player, stat_amount)
      puts " #{index + 1}. #{player}..........#{stat_amount} "
      index += 1
    end
  end
  
  def self.rbi
    index = 0
    MlbStats::LeagueLeaders.all.clear
    stats[:rbi].each_slice(2) do |player, stat_amount|
      MlbStats::LeagueLeaders.new(player, stat_amount)
      puts " #{index + 1}. #{player}...........#{stat_amount}"
      index += 1
    end
  end
  
  def self.era
    index = 0
    MlbStats::LeagueLeaders.all.clear
    stats[:era].each_slice(2) do |player, stat_amount|
      MlbStats::LeagueLeaders.new(player, stat_amount)
      puts " #{index + 1}. #{player}..........#{stat_amount} "
      index += 1
    end
  end
  

  
  def self.get_teams(doc)           #scraper to get teams
    @teams = []
    doc.search("td.Table__TD").each do |x|
      @teams << x.css("span.hide-mobile a").text
    end
    @teams.reject! {|x| x.empty? }
  end
  
  def self.get_stats(doc)     #scraper to get player and stat amounts
    
    @players = []
    doc.search('tr[align="right"]').each do |x|
      @player = x.css('td[align="left"] a').text
      @stat_amount = x.css('td[align="right"].sortcell' ).text
      @players << @player
      @players << @stat_amount
      
    end
    @players.reject! {|x| x.empty?}
    
  end
  
  
end


