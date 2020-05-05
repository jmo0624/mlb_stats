class MlbStats::LeagueLeaders
  
  attr_accessor :name, :avg, :hr, :rbi, :era
  @@all = []
  
  def initialize(params, stat_amount)
    @name ||= params[0]
    @avg ||= params[1][0]
    @hr ||= params[1][1]
    @rbi ||= params[1][2]
    @era ||= params[1][3]
    
    @@all << self
  end
  
  def self.all
    @@all
  end
  

  
end
  
  
