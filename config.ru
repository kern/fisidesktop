require 'sinatra'

get '/' do
  send_file 'index.html'
end

get '/png' do
  cache_control :public, max_age: 1
  send_file Dir['images/*.png'].sample
end

run Sinatra::Application
