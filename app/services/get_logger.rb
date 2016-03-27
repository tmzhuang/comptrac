class GetLogger 
  def self.call
    logger = DependencyGrapher::Logger.new
  end
end
