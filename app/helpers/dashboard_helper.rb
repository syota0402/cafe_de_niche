module DashboardHelper
  def my_edit_link_to(items,id)
    "#{items}/#{id}/edit"
  end
  
  # editページもやりたい
  # def my_update_link_to(items,id)
  #   "dashbord/#{items}/#{id}"
  # end
end
