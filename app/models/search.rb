class Search < ApplicationRecord
    
  def self.search(str, path, type)
    return all unless str
    case type
    when "forward"
      where(["#{path} LIKE ?", "#{str}%"])
    when "backward"
      where(["#{path} LIKE ?", "%#{str}"])
    when "partial"
      where(["#{path} LIKE ?", "%#{str}%"])
    when "exact"
      where(["#{path} LIKE ?", "#{str}"])
    else
    end
  end
end
