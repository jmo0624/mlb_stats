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
    elsif input == "strikeouts"
      @doc = Nokogiri::HTML(open("http://www.espn.com/mlb/stats/pitching/_/seasontype/2/sort/strikeouts/order/true"))
    elsif input == "saves"
      @doc = Nokogiri::HTML(open("http://www.espn.com/mlb/stats/pitching/_/seasontype/2/sort/saves/order/true"))
    end

  end
  
  def self.stats
    stats = {}
    stats[:standings] = self.get_teams(get_page("standings"))
    stats[:batting_average] = self.get_avg(get_page("batting average"))
    stats[:home_runs] = self.get_hr(get_page("home runs"))
    stats[:rbi] = self.get_rbi(get_page("runs batted in"))
    stats[:era] = self.get_era(get_page("earned run average"))
    stats[:strikeout] = self.get_strikeout("strikeouts")
    stats[:saves] = self.get_saves("saves")
    stats
  end
  
  def self.teams
    MlbStats::Teams.all.clear
    stats[:standings] do |team|
      MlbStats::Teams.new(team)
    end
  end
  
  def self.batting_average
    MlbStats::LeagueLeaders.all.clear
    stats[:batting_average] do |player|
      MlbStats::LeagueLeaders.new(player)
    end
  end
  
  def self.home_runs
    MlbStats::LeagueLeaders.all.clear
    stats[:home_runs] do |player|
      MlbStats::LeagueLeaders.new(player)
    end
  end
  
  def self.rbi
    MlbStats::LeagueLeaders.all.clear
    stats[:rbi] do |player|
      MlbStats::LeagueLeaders.new(player)
    end
  end
  
  def self.era
    MlbStats::LeagueLeaders.all.clear
    stats[:era] do |player|
      MlbStats::LeagueLeaders.new(player)
    end
  end
  
  def self.strikeout
    MlbStats::LeagueLeaders.all.clear
    stats[:strikeout] do |player|
      MlbStats::LeagueLeaders.new(player)
    end
  end
  
  def self.saves
    MlbStats::LeagueLeaders.all.clear
    stats[:saves] do |player|
      MlbStats::LeagueLeaders.new(player)
    end
  end
  
  def self.get_teams(doc)
    @teams = []
    doc.search("td.Table__TD").each do |x|
      @teams << x.css("span.hide-mobile a").text
    end
    @teams.reject! {|x| x.empty? }
  end
  
  def self.get_avg(doc)
    @avg = []
    doc.search('tr[align="right"]').each do |x|
      @avg << x.css('td[align="left"] a').text
    end
    @avg.reject! {|x| x.empty?}
  end
  
  def self.get_hr(doc)
    @hr = []
    doc.search('tr[align="right"]').each do |x|
      @hr << x.css('td[align="left"] a').text
    end
    @hr.reject! {|x| x.empty?}
  end
  
  def self.get_rbi(doc)
    @rbi = []
    doc.search('tr[align="right"]').each do |x|
      @rbi << x.css('td[align="left"] a').text
    end
    @rbi.reject! {|x| x.empty?}
  end
  
  def self.get_era(doc)
    @era = []
    doc.search('tr[align="right"]').each do |x|
      @era << x.css('td[align="left"] a').text
    end
    @era.reject! {|x| x.empty?}
  end
  
  def self.get_strikeout(doc)
    @so = []
    doc.search('tr[align="right"]').each do |x|
      @so << x.css('td[align="left"] a').text
    end
    @so.reject! {|x| x.empty?}
  end
  
  def self.get_saves(doc)
    @saves = []
    doc.search('tr[align="right"]').each do |x|
      @saves << x.css('td[align="left"] a').text
    end
    @saves.reject! {|x| x.empty?}
  end
  
end
