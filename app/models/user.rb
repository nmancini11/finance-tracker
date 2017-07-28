class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :followerships
  has_many :followers, through: :followerships

  def full_name
    return "#{first_name} #{last_name}".strip if (first_name || last_name)
    "Anonymous"
  end

  def can_add_stock?(ticker_symbol)
    # is the user under their limit && is the stock in the users portfolio
    under_stock_limit? && !stock_already_added?(ticker_symbol)
  end

  def under_stock_limit?
    # limit user to 50 stocks
    (user_stocks.count < 50)
  end

  def stock_already_added?(ticker_symbol)
    # check if the stock is in the DB
    stock = Stock.find_by_ticker(ticker_symbol)
    # if the stock is not there, return false. The stock is not in the DB
    return false unless stock
    user_stocks.where(stock_id: stock.id).exists?
  end
end
