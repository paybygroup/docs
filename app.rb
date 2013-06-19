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
require 'github/markup'

@@status = 'up'
@@last_check_status = Time.current

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  [username, password] == ['merchant', 'docs']
end

def get_status
  if @@last_check_status +30.minutes < Time.current
    unless defined? @@client
      @@client = Pingdom::Client.new(
        :username => 'webmaster@paybygroup.com',
        :password => 'newcrew11',
        :key => 'ynla346encc9zl3ou0rsdxd3d5uzylrx')
    end
    @@last_check_status = Time.current
    @@status = @@client.test!(:host => "lets.paybygroup.com", :type => "http").status
  else
    @@status
  end
end

get '/' do
  @status = get_status
  client = Pingdom::Client.new(
    :username => 'webmaster@paybygroup.com',
    :password => 'newcrew11',
    :key => 'ynla346encc9zl3ou0rsdxd3d5uzylrx')
  @index = GitHub::Markup.render("contents/index.md")
  haml :index
end

get '/:article' do
  @status = get_status
  @content = GitHub::Markup.render( "contents/" + params["article"].gsub("-", "_").concat(".md"))
  doc_title = Nokogiri::HTML::DocumentFragment.parse( @content ).css('h1').first.inner_html()
  @sidebar = Nokogiri::HTML::DocumentFragment.parse( @content ).css('h2')
  @title = "#{doc_title} | PayByGroup Documentation"
  haml :article
end

get '/stylesheets/*' do
  content_type 'text/css'
  sass '../styles/'.concat(params[:splat].join.chomp('.css')).to_sym
end
