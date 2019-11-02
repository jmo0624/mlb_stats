class MlbStats::Scraper
  
  def self.get_page(input)
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
    #elsif input == "strikeouts"
      #@doc = Nokogiri::HTML(open("http://www.espn.com/mlb/stats/pitching/_/seasontype/2/sort/strikeouts"))
    #elsif input == "saves"
     # @doc = Nokogiri::HTML(open("http://www.espn.com/mlb/stats/pitching/_/seasontype/2/sort/saves/order/true"))
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
  
  def self.teams
    index = 0
    MlbStats::Teams.all.clear
    stats[:standings].each do |team|
      MlbStats::Teams.new(team)
      puts " #{index + 1}. #{team}"
      index += 1
    end
  end
  
  def self.batting_average
    index = 0
    MlbStats::LeagueLeaders.all.clear
    stats[:batting_average].each do |player|
      MlbStats::LeagueLeaders.new(player)
      puts " #{index + 1}. #{player}."
      index += 1
    end
  end
  
  def self.home_runs
    index = 0
    MlbStats::LeagueLeaders.all.clear
    stats[:home_runs].each do |player|
      MlbStats::LeagueLeaders.new(player)
      puts " #{index + 1}. #{player}. "
      index += 1
    end
  end
  
  def self.rbi
    index = 0
    MlbStats::LeagueLeaders.all.clear
    stats[:rbi].each do |player|
      MlbStats::LeagueLeaders.new(player)
      puts " #{index + 1}. #{player}. "
      index += 1
    end
  end
  
  def self.era
    index = 0
    MlbStats::LeagueLeaders.all.clear
    stats[:era].each do |player|
      MlbStats::LeagueLeaders.new(player)
      puts " #{index + 1}. #{player}. "
      index += 1
    end
  end
  

  
  def self.get_teams(doc)
    @teams = []
    doc.search("td.Table__TD").each do |x|
      @teams << x.css("span.hide-mobile a").text
    end
    @teams.reject! {|x| x.empty? }
  end
  
  def self.get_stats(doc)
    #@players = []
    @stats = []
    doc.search('tr[align="right"]').each do |x|
      @player = x.css('td[align="left"] a').text
      #@stat_amount = x.css('td[align="right"].sortcell' ).text
      @stats << @player
      #"#{@players.concat(@stats)}"
    end
    @stats.reject! {|x| x.empty?}
  end
  
  
  
end

#'td[align="right"].sortcell'
