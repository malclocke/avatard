namespace :avatar do
  desc "Fetch from gravatar"
  task :fetch, [:email]  => :environment do |t, args|
    require 'open-uri'
    email = args[:email]
    raise "You must provide an email address" unless email
    puts "Fetching #{email} ..."
    avatar = Avatar.new :email => email
    avatar.set_checksum
    open("http://gravatar.com/avatar/#{avatar.checksum}?s=256") do |f|
      avatar.avatar = f.read
    end
    avatar.save!
  end
end
