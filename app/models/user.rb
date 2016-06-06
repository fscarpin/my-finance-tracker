class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true, length: { minimum: 3, maximum: 20 }

  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  has_many :friendships
  has_many :friends, through: :friendships

  MAXIMUN_NUMBER_OF_STOCKS = 10

  def can_add_stock? (ticker)
    return !stock_already_added?(ticker) && under_stock_limit?
  end

  def under_stock_limit?
    (user_stocks.count < MAXIMUN_NUMBER_OF_STOCKS) ? true : false
  end

  def stock_already_added? (ticker)
    # If the stock is not in the stocks table, it means it wasn't added
    stock = Stock.where(ticker: ticker).first
    return false if !stock

    # Check if the user have this stock
    return user_stocks.where(stock_id: stock.id).exists?
  end

  def full_name
    if first_name.present? || last_name.present?
      return "#{first_name} #{last_name}".strip
    end
  end
end
