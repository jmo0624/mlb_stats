class MlbStats::Teams
  
  attr_accessor :name, :wins, :losses, :division, :conference
  
  @@all = []
  
  def initialize(params)
    @name ||= params[0]
    @wins ||= params[1][0]
    @losses ||= params[1][1]
    @division ||= params[1][2]
    @conference ||= params[1][3]
    @@all << self
  end
  
  def self.all
    @@all
  end
  
end
    