class CoffeeShopSearchService
  def initialize(name,tell,search_category_ids)
    @name = name
    @tell = tell
    @search_category_ids = search_category_ids
  end
  
  def search
    @coffee_shops = CoffeeShop.all
    
    # 店舗名　一部一致
    search_by_name if @name.present?
    
    # 電話番号　完全一致
    search_by_tell if @tell.present?
    
    search_by_search_category_ids if @search_category_ids.present?
    @coffee_shops
  end
  
  private
  
  def search_by_name
    @coffee_shops = @coffee_shops.where('name LIKE ?', "%#{@name}%")
  end
  
  def search_by_tell
    @coffee_shops = @coffee_shops.where(tell: @tell)
  end
  
  def search_by_search_category_ids
    coffee_shop_ids = CoffeeShopSearchCategory.where(search_category_id: @search_category_ids).pluck(:coffee_shop_id)
    @coffee_shops = @coffee_shops.where(id: coffee_shop_ids)
  end
end