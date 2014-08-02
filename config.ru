require 'sinatra'

get '/' do
  send_file 'index.html'
end

get '/png' do
  send_file Dir['images/*.png'].sample
end

run Sinatra::Application
