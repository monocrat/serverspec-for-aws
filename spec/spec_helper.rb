require 'serverspec'

if ENV['ASK_LOGIN_PASSWORD']
  puts "helllo"
#  options[:password] = ask("\nEnter login password: ") { |q| q.echo = false }
else
  puts "fuck you"
#  options[:password] = ENV['LOGIN_PASSWORD']
end

set :backend, :exec

