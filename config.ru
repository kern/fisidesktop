require 'sinatra'

get '/' do
  send_file 'index.html'
end

get '/favicon.ico' do
  send_file 'favicon.ico'
end

get '/facebook.png' do
  send_file 'facebook.png'
end

get '/png' do
  send_file Dir['images/*.png'].sample
end

run Sinatra::Application
