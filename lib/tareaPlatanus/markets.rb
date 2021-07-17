#require 'faraday'
#require 'json'

class MarketsObj
  def initialize(url)
    @_url = url
  end

  def get_markets_lst
    response = Faraday.get(@_url)
    markets_obj = JSON.parse(response.body, {object_class: OpenStruct})
    markets_lst = []
    for idx in (0..(markets_obj['markets'].length - 1)).to_a # 19 iteraciones.
      markets_lst.append(markets_obj['markets'][idx]['id'])
    end
    return markets_lst
  end
end
    
