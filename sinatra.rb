require 'sinatra'
set :public_folder, File.dirname(__FILE__) + '/public_folder'
set :views, File.dirname(__FILE__) + '/views'

get '/' do
    'hello worldddd!'
    'hhhhhhhhhhhhhhhhhhhhh' 
    # gem instal shotgun  autoload the script instead of restart every time where modify something
    # shotgun sinatra.rb
end

get '/hello/:name' do
    @tian = params[:name]
    @bao = 'HHHHHHHHHHHHHHHHHHHHHHHHhh'
    erb :hello
end

get '/bird/:sex' do
    erb :"hello/world", :layout => :post
end

get '/more/*/tian/*' do  
    # http://127.0.0.1:9393/more/haha/tian/just for test
    params[:splat][0] #  haha
    params[:splat][1] #  just for test
end  
