# encoding: UTF-8

require 'sinatra'
require 'sinatra/contrib/all'
require 'sinatra/reloader' if development?
require 'haml'
require 'sass'
require 'rdiscount'
require 'nokogiri'
require 'pry'
require 'pingdom-client'

@@status = get_status

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  [username, password] == ['merchant', 'docs']
end

def get_status
  unless defined? @@client
    @@client = Pingdom::Client.new(
      :username => 'webmaster@paybygroup.com', 
      :password => 'newcrew11', 
      :key => 'ynla346encc9zl3ou0rsdxd3d5uzylrx')
  end
    @@client.test!(:host => "lets.paybygroup.com", :type => "http").status
end

get '/' do
  @@status = get_status
  client = Pingdom::Client.new(
    :username => 'webmaster@paybygroup.com', 
    :password => 'newcrew11', 
    :key => 'ynla346encc9zl3ou0rsdxd3d5uzylrx')
  @index = RDiscount.new( File.open("contents/index.md").read ).to_html
  haml :index
end

get '/:article' do
  @@status = get_status
  @content = RDiscount.new( File.open("contents/" + params["article"].gsub("-", "_").concat(".md")).read ).to_html
  doc_title = Nokogiri::HTML::DocumentFragment.parse( @content ).css('h1').first.inner_html()
  @sidebar = Nokogiri::HTML::DocumentFragment.parse( @content ).css('h4')
  @title = "#{doc_title} | PayByGroup Documentation"
  haml :article
end
  
get '/stylesheets/*' do
  content_type 'text/css'
  sass '../styles/'.concat(params[:splat].join.chomp('.css')).to_sym
end
