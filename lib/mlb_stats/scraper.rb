class MlbStats::Scraper
  
  def self.get_page(input)
    if input == "standings"
      @doc = Nokogiri::HTML(open("http://www.espn.com/mlb/standings/_/group/overall"))
    end

  end
  
  def self.stats
    stats = {}
    stats[:standings] = self.get_teams(get_page("standings"))
    stats
  end
  
  def self.teams
    MlbStats::Teams.all.clear
    stats.each do |team|
      MlbStats::Teams.new(team)
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
  end
  
end