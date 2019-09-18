class MlbStats::Scraper
  
  def self.get_page(input)
    if input == "standings"
      @doc = Nokogiri::HTML(open("http://www.espn.com/mlb/standings/_/group/overall"))
    elsif input == "batting average"
      @doc = Nokogiri::HTML(open("http://www.espn.com/mlb/stats/batting/_/year/2019/seasontype/2"))
    elsif input == "home runs"
      @doc = Nokogiri::HTML(open("http://www.espn.com/mlb/stats/batting/_/sort/homeRuns/order/true"))
    end

  end
  
  def self.stats
    stats = {}
    stats[:standings] = self.get_teams(get_page("standings"))
    stats[:batting_average] = self.get_avg(get_page("batting average"))
    stats
  end
  
  def self.teams
    MlbStats::Teams.all.clear
    stats[:standings].each do |team|
      MlbStats::Teams.new(team)
    end
  end
  
  def self.league_leaders
    MlbStats::LeagueLeaders.all.clear
    stats[:batting_average] do |player|
      MlbStats::LeagueLeaders.new(player)
    end
  end
  
  def self.get_teams(doc)
    @teams = []
    doc.search("td.Table2__td").each do |x|
      @teams << x.css("span.hide-mobile a").text
    end
    @teams.reject! {|x| x.empty? }
  end
  
  def self.get_avg(doc)
   # @avg_doc = Nokogiri::HTML(open("http://www.espn.com/mlb/stats/batting/_/year/2019/seasontype/2"))
    @avg = []
    doc.search('tr[align="right"]').each do |x|
      @avg << x.css('td[align="left"] a').text
    end
    @avg.reject! {|x| x.empty?}
  end
  
end
