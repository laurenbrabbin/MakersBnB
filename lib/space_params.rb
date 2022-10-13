require_relative './space'
require_relative './space_repository'

class SpaceParams
  def initialize(name, description, price)
    @name = name
    @description = description
    @price = price
  end

  def name_contains_incorrect_characters?
    @name.gsub!(/[^A-Za-z -.]/, '') == @name 
  end

  def description_contains_incorrect_characters?
    @description.gsub!(/[^0-9A-Za-z-_ ]/, '') == @description 
  end

  def incorrect_pricing?
    @price.to_i.to_s != @price
  end 

  def invaild_space_params?
    name_contains_incorrect_characters? || description_contains_incorrect_characters? || duplicate_name? || incorrect_pricing?
  end
end