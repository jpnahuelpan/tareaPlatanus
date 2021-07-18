require './lib/tareaPlatanus.rb'
require 'faraday'
require 'json'
require 'date'
require 'sinatra'

MILISECONDS_PER_DAY = 86400000
MILISECONDS_PER_HOUR = 3600000

markets_url = 'https://www.buda.com/api/v2/markets'
markets = MarketsObj.new(markets_url)
markets_lst = markets.get_markets_lst
trades_array = []


for market in markets_lst
  puts "Se está procesando el mercado: #{market}"
  trades_array.append(TradesByTime.new(markets_url, MILISECONDS_PER_DAY, market).get_max_amount)
end

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"

get '/' do
    m_lst = markets_lst
    t_array = trades_array
    
    for t in t_array
    	if t[0][0] != 'E'
    		t[0] = DateTime.strptime((t[0].to_i - (MILISECONDS_PER_HOUR * 4)).to_s, '%Q').to_s
    		for i in (1..6)
    			t[0].slice!(-1)
    		end	
		end
    end	
    erb :index, :locals => {'m_lst' => m_lst, 't_array' => t_array}
end
