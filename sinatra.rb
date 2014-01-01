require 'sinatra'
set :public_folder, File.dirname(__FILE__) + '/public_folder'
get '/' do
    'hello worldddd!'
end

get '/hello/:name' do
    @tian = params[:name]
    @bao = 'HHHHHHHHHHHHHHHHHHHHHHHHhh'
    erb :hello
end
