# ruby --veriosn 2.0.0
require 'sinatra'
require 'data_mapper'

helpers do  
    include Rack::Utils  
    alias_method :h, :escape_html  
end  

SITE_TITLE = "备忘录"  
SITE_DESCRIPTION = "你太忙了，没时间记，让我来帮你吧"  
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

get '/rss.xml' do  
    @notes = Note.all :order => :id.desc  
    builder :rss  
end  

get '/:id' do  
    @note = Note.get params[:id]  
    @title = "Edit note ##{params[:id]}"  
    erb :edit  
end  

put '/:id' do  
    n = Note.get params[:id]  
    n.content = params[:content]  
    n.complete = params[:complete] ? 1 : 0  
    n.updated_at = Time.now  
    n.save  
    redirect '/'  
end  

get '/:id/delete' do  
    @note = Note.get params[:id]  
    @title = "Confirm deletion of note ##{params[:id]}"  
    erb :delete  
end  

delete '/:id' do  
    n = Note.get params[:id]  
    n.destroy  
    redirect '/'  
end  

get '/:id/complete' do  
    n = Note.get params[:id]  
    n.complete = n.complete ? 0 : 1 # flip it  
    n.updated_at = Time.now  
    n.save  
    redirect '/'  
end  

helpers do  
    include Rack::Utils  
    alias_method :h, :escape_html  
end  
# if no such a controler
not_found do
    halt 404, 'page not found'
end
