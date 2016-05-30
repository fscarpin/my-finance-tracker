class Stock < ActiveRecord::Base

  def self.find_by_ticker(symbol_ticker)
    where(ticker: symbol_ticker).first
  end

  def self.new_from_lookup(symbol_ticker)
    quotes = Stock.pricer.quotes([symbol_ticker], [:name]).first

    return if !Stock.valid_quotes?(quotes)

    stock = new(ticker: symbol_ticker, name: quotes.name)
    stock.last_price = stock.price

    return stock
  end

  def price
    quotes = Stock.pricer.quotes([ticker], [:close]).first

    if Stock.valid_quotes?(quotes)
      return quotes.close
    else
      return "Unavailable"
    end
  end

  private
  def self.valid_quotes? (quotes)
    return !(quotes.name == "N/A")
  end

  def self.pricer
    return YahooFinance::Client.new
  end
end
