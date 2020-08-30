def stock_picker prices
    prices_sorted = prices.sort.reverse
    profit = 0
    best_days = []
    prices_sorted.each do | sell_price |
        prices.each do | buy_price |
            if buy_price < sell_price && prices.index(sell_price) > prices.index(buy_price) && sell_price - buy_price > profit
                best_days = [ prices.index(buy_price) , prices.index(sell_price) ]
                profit = sell_price - buy_price
            end    
        end
    end         
    best_days    
end


p stock_picker [17,3,6,9,15,8,6,1,10]