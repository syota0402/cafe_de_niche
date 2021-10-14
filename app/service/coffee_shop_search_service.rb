class CoffeeShopSearchService
  def initialize(name,tell)
    @name = name
    @tell = tell
  end
  
  def search
    @coffee_shops = CoffeeShop.all
    
    # 店舗名　一部一致
    search_by_name if @name.present?
    
    # 電話番号　完全一致
    search_by_tell if @tell.present?
    
    @coffee_shops
  end
  
  private
  
  def search_by_name
    @coffee_shops = @coffee_shops.where('name LIKE ?', "%#{@name}%")
  end
  
  def search_by_tell
    @coffee_shops = @coffee_shops.where(tell: @tell)
  end
end