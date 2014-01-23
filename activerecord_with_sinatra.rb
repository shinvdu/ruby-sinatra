require 'sinatra'
require 'active_record'
require 'mysql2'

ActiveRecord::Base.establish_connection(
    :adapter => 'mysql2',
    :host => 'localhost',
    :database => 'rssfeed',
    :username => 'root',
    :password => 'H0tmail!8'
)

class Ttrss_entries < ActiveRecord::Base
end

get '/hi' do
    tian = Ttrss_entries.last
    tian.content
end
