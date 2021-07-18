require './lib/tareaPlatanus.rb'
require 'faraday'
require 'json'
require 'date'


MILISECONDS_PER_DAY = 86400000

markets_url = 'https://www.buda.com/api/v2/markets'
markets = MarketsObj.new(markets_url)

dia = TradesByTime.new(markets_url, MILISECONDS_PER_DAY, markets.get_markets_lst[0])
#puts markets.get_markets_lst[0]
#puts dia.get_max_amount

array = []
for market in markets.get_markets_lst
  puts "estamos en este mercado: #{market}"
  array.append(TradesByTime.new(markets_url, MILISECONDS_PER_DAY, market).get_max_amount)
end
puts array[0]
