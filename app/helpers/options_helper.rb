module OptionsHelper

  def attr_boolean?(item,attr)
    item.class.column_types[attr.to_s].class == ActiveRecord::Type::Boolean
  end


  def option_li( page,title, url = nil )
    #p "page",page,"@page_data",@page
    css_class = @page == page ? "active" : nil
    lnk = url.nil? ? '#' : page
    #p "lnk",lnk,url
    content_tag :li, {:class =>css_class } do

      link_to title, lnk,{:class =>"list-group-item #{css_class}", :controller => page}
    end
  end


  def get_active_option_page

  	case @page
  	when 'leads','statuses','channels','lead_sources'
  		0
    when 'project_statuses','project_types'
      1
    when 'payment_types','payment_purposes'
      2
  	when 'providers','budgets','goodstypes','styles','p_statuses'
  		3
    when 'absence_reasons', 'absence_targets','absence_shop_targets'
      5
  	else
  		4
  	end
  			
  end

end
