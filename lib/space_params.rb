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

  def duplicate_name?
    repo = SpaceRepository.new
    all_spaces = repo.all
    duplicate_space = false

    all_spaces.each do |space|
      if @name.downcase == space.name.downcase
        duplicate_name = true
      end
    end
    return duplicate_space
  end

  def invaild_space_params?
    duplicate_name? || name_contains_incorrect_characters? || description_contains_incorrect_characters? || duplicate_name? || incorrect_pricing?
  end
end