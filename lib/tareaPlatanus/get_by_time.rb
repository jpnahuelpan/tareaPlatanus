class TradesByTime
  def initialize(url, period, market_id)
    @_url = url
    @_timestamp = DateTime.now.strftime('%Q').to_i
    @_fs = (@_timestamp - period)
    @_market = market_id
  end

  def get_max_amount
    count = 0
    trades_ostruct = OpenStruct.new
    loop do
      response = Faraday.get(@_url + "/#{@_market}/trades?timestamp=#{@_timestamp}&limit=100")
      response_ostruct = JSON.parse(response.body, {object_class: OpenStruct})

      if count == 0      
        trades_ostruct['last_timestamp'] = response_ostruct['trades']['last_timestamp']  
        trades_ostruct['entries'] = response_ostruct['trades']['entries']       
      else  
        trades_ostruct['last_timestamp'] = response_ostruct['trades']['last_timestamp']
        for idx in (0..response_ostruct['trades']['entries'].length - 1)
          trades_ostruct['entries'].append(response_ostruct['trades']['entries'][idx])
        end  
      end
      break if (trades_ostruct['last_timestamp'].to_i < @_fs) 
      
      # puts "exito break if #{count} con last_timestamp: #{trades_ostruct['last_timestamp']}"
      count += 1
      @_timestamp = trades_ostruct['last_timestamp'].to_i 
    end  
    amount_lst = []
    # puts trades_ostruct['last_timestamp'], @_fs
    # puts trades_ostruct['entries']
    for idx in (0..trades_ostruct['entries'].length - 1)
      # entries: [[timestamp, amount, price, direction],...]
      # puts "#{trades_ostruct['entries'][idx][1]}: indice,#{idx}"  
      if trades_ostruct['entries'][idx][0].to_i < @_fs
        # puts "se rompió en #{idx}"
        break
      end
      amount_lst.append(trades_ostruct['entries'][idx][1].to_f * trades_ostruct['entries'][idx][2].to_f)
    end
    idx_max = amount_lst.index(amount_lst.max)
    # puts "idx_max: #{idx_max}"
    if idx_max == nil
      return "El mercado de #{@_market} no a registrado transacciones las últimas 24hrs."
    elsif amount_lst[idx_max] == (trades_ostruct['entries'][idx_max][1].to_f * trades_ostruct['entries'][idx_max][2].to_f)
      return trades_ostruct['entries'][idx_max]
    else
      puts 'Uppss algo salio mal!'
    end  
  end
end  
      
    
