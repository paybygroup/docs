# encoding: UTF-8

require 'sinatra'
require 'sinatra/content_for'
require 'sinatra/reloader' if development?
require 'haml'
require 'sass'
require 'rdiscount'
require 'nokogiri'

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  [username, password] == ['merchant', 'viewdocs']
end

get '/' do
  @index = RDiscount.new( File.open("contents/index.md").read ).to_html
  haml :index
end

get '/:article' do
  @content = RDiscount.new( File.open("contents/" + params["article"].gsub("-", "_").concat(".md")).read ).to_html
  doc_title = Nokogiri::HTML::DocumentFragment.parse( @content ).css('h1').inner_html()  
  @title = "#{doc_title} | PayByGroup Documentation"
  haml :article
end
  
get '/stylesheets/*' do
  content_type 'text/css'
  sass '../styles/'.concat(params[:splat].join.chomp('.css')).to_sym
end
