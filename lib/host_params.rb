require_relative './host'


class HostParams
  def initialize(name, username, email, password)
    @name = name
    @username = username
    @email = email
    @password = password
  end

  def invalid_email?
    (@email !~ /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i) 
  end

  def name_contains_incorrect_characters?
    @name.gsub!(/[^A-Za-z -.]/, '') == @name 
  end

  def username_contains_incorrect_characters?
    @username.gsub!(/[^0-9A-Za-z-_]/, '') == @username 
  end

  def password_contains_incorrect_characters?
    @password.gsub!(/[^0-9A-Za-z .!?*@&+-,]/, '') == @password
  end

  def weak_password?
    @password.length < 8 || @password.count("0-9") == 0
  end 

  def duplicate_username?
    repo = HostRepository.new 
    all_hosts = repo.all
    duplicate_username = false

   all_hosts.each do |host|
      if @username.downcase == host.username.downcase
        duplicate_username = true
      end
    end
    return duplicate_username
 end

 def duplicate_email?
  repo = HostRepository.new 
  all_hosts = repo.all
  duplicate_email = false

  all_hosts.each do |host|
    if @email.downcase == host.email.downcase
      duplicate_email = true
    end
  end
   return duplicate_email
 end

  def invaild_host_params?
    duplicate_username? || duplicate_email? || invalid_email?  || weak_password? || name_contains_incorrect_characters? || username_contains_incorrect_characters? || password_contains_incorrect_characters?
  end
end