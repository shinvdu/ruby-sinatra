require 'sinatra'
set :public_folder, File.dirname(__FILE__) + '/public_folder'
#set :views, File.dirname(__FILE__) + '/templates'

get '/' do
    'hello worldddd!'
end

get '/hello/:name' do
    @tian = params[:name]
    @bao = 'HHHHHHHHHHHHHHHHHHHHHHHHhh'
    erb :hello
end

get '/bird/:sex' do
    erb :"hello/world"
end
