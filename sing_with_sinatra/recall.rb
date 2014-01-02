# ruby --veriosn 2.0.0
require 'sinatra'
require 'data_mapper'
set :public_folder, File.dirname(__FILE__) + '/public'
set :views, File.dirname(__FILE__) + '/views' # this is necessary when using shotgun

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/recall.db")  

class Note  
    include DataMapper::Resource  
    property :id, Serial  
    property :content, Text, :required => true  
    property :complete, Boolean, :required => true, :default => false  
    property :created_at, DateTime  
    property :updated_at, DateTime  
end  

DataMapper.finalize.auto_upgrade!  

get '/' do  
    @notes = Note.all :order => :id.desc  
    @title = 'All Notes'  
    erb :home  
end  

post '/' do  
    n = Note.new  
    n.content = params[:content]  
    n.created_at = Time.now  
    n.updated_at = Time.now  
    n.save  
    redirect '/'  
end  
# if no such a controler
not_found do
    halt 404, 'page not found'
end
