class MlbStats::LeagueLeaders
  
  attr_accessor :name, :avg, :hr, :rbi, :era, :so, :saves
  
  @@all = []
  
  def initialize(params)
    @name ||= params[0]
    @avg ||= params[1][0]
    @hr ||= params[1][1]
    @rbi ||= params[1][2]
    @era ||= params[1][3]
    @so ||= params[1][4]
    @saves ||= params[1][5]
    @@all << self
  end
  
  def self.all
    @@all
  end
  
end
  
  
  #my-players-table > div > div.mod-content > table > tbody > tr.oddrow.player-10-32098 > td:nth-child(2) > a  