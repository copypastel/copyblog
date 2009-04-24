class Attraction < ActiveRecord::Base
  has_many :comments
  
  def outline
    eval super
  end
  
  def outline=(array)
    string_array = "["
    first = true
    array.each do |title,depth| 
      unless first
        string_array << ',' # for list
      end
      string_array<< "['#{title}',#{depth}]"
      first = false
    end
    string_array << "]"
    super(string_array)
  end
end
