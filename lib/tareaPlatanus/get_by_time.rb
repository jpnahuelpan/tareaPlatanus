class TradesByTime
  def initialize(url, period, market_id)
    @_url = url
    @_timestamp = DateTime.now.strftime('%Q').to_i
    @_fs = (@_timestamp - period)
    @_market = market_id
  end

  def get()
    count = 0
    trades_ostruct = OpenStruct.new
    loop do
      puts 'inicio el lopp manooo!'
      response = Faraday.get(@_url + "/#{@_market}/trades?timestamp=#{@_timestamp}&limit=100")
      response_ostruct = JSON.parse(response.body, {object_class: OpenStruct})

      if count == 0      
        trades_ostruct['last_timestamp'] = response_ostruct['trades']['last_timestamp']  
        trades_ostruct['entries'] = response_ostruct['trades']['entries']   
                
      else
        puts 'else 1 comenzo!' 
        trades_ostruct['last_timestamp'] = response_ostruct['trades']['last_timestamp']
        trades_ostruct['entries'].append(response_ostruct['trades']['entries'][0..])
        puts 'exito en else'
      end

      break if (trades_ostruct['last_timestamp'].to_i < @_fs) 
      
      puts "exito break if #{count} con last_timestamp: #{trades_ostruct['last_timestamp']}"
      count += 1
      @_timestamp = trades_ostruct['last_timestamp'].to_i  
    end  
    trades_lst = []
    # puts trades_ostruct['last_timestamp'], @_fs

    for idx in (0..trades_ostruct['entries'].length - 1)
      # entries: [[timestamp, amount, price, direction],...]
      # puts trades_ostruct['entries'][idx][1], idx  
      if trades_ostruct['entries'][idx][0].to_i < @_fs
        break
      end
    end
  end
end  
      
    
