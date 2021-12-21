module DashboardHelper
  def my_edit_link_to(items,id)
    "#{items}/#{id}/edit"
  end
  
  def my_destroy_link_to(item,id)
    "#{item}/#{id}/destroy"
  end
end
