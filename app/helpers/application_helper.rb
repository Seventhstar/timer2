module ApplicationHelper

#  def elem_by_attr(item,attr)
#    case item.class.column_types[attr.to_s].class
#    when ActiveRecord::Type::Boolean
#    when ActiveRecord::Type::DateTime
#    else
#      <td><%= item[attr[0]] %></td>
#    end
#     
#  end

  def td_tool_icons(element,str_icons='edit,delete',params = nil)
    
    all_icons = {} #['edit','delete','show'] tag='span',subcount=nil
    params ||= {}
    params[:tag] ||= 'href' 
    icons = str_icons.split(',')
    params[:subcount] ||= 0
    params[:add_cls] ||= ''
    dilable_cls = params[:subcount]>0 ? '_disabled' : ''
    if params[:tag] == 'span' 
      all_icons['edit'] = content_tag :span, "", {class: 'icon icon_edit', item_id: element.id}
      all_icons['delete'] = content_tag( :span,"",{class: ['icon icon_remove',dilable_cls,' ',params[:add_cls]].join, item_id: params[:subcount]>0 ? '' : element.id})
     else
      all_icons['edit'] = link_to "", edit_polymorphic_path(element), class: "icon icon_edit"
      all_icons['show'] = link_to "", polymorphic_path(element), class: "icon icon_show", data: { modal: true }
      all_icons['delete'] = link_to "", element, method: :delete, data: { confirm: 'Действительно удалить?' }, class: "icon icon_remove " if params[:subcount]==0
      all_icons['delete'] = content_tag(:span,"",{class: 'icon icon_remove_disabled'}) if params[:subcount]>0
    end
    content_tag :td,{:class=>"edit_delete"} do
      icons.collect{ |i| all_icons[i] }.join.html_safe
    end

  end


  def chosen_src( id, collection, obj = nil, options = {})  
    p_name    = options[:p_name].nil? ? 'name' : options[:p_name]
    order     = options[:order].nil? ? p_name : options[:order]
    nil_value = options[:nil_value].nil? ? 'Выберите...' : options[:nil_value]
    
  	coll = collection.class.ancestors.include?(ActiveRecord::Relation) ? collection : collection
    coll = coll.collect{ |u| [u[p_name], u.id] }
    coll.insert(0,[nil_value,nil]) if nil_value != ''
    coll.insert(1,[options[:special_value],-1]) if !options[:special_value].nil?

		is_attr = (obj.class != Fixnum && obj.class != String && !obj.nil?)
    sel = is_attr ? obj[id] : obj
    sel = options[:selected] if !options[:selected].nil?
    	n = is_attr ? obj.model_name.singular+'['+ id.to_s+']' : id

    def_cls = coll.count < 8 ? 'chosen' : 'schosen'
    cls       = options[:class].nil? ? def_cls : options[:class]
    
    cls = cls+" has-error" if is_attr && ( obj.errors[id].any? || obj.errors[id.to_s.gsub('_id','')].any? )
    l = label_tag options[:label]
    s = select_tag n, options_for_select(coll, :selected => sel), class: cls
    options[:label].nil? ? s : l+s
  end



  def is_admin?
    current_user.try(:admin?)
  end

  def opt_page
     if self.controller_name =='tasks' 
        'tasks'
     else
        'tasks'
     end
  end

  def td_delete(element,subcount = nil)
    content_tag :td,{:class=>"edit_delete"} do
      de = link_to image_tag('delete.png'), element, method: :delete, data: { confirm: 'Действительно удалить?' }
    end
  end

  def td_span_delete(element,subcount = nil, cls = '')
    content_tag :td,{:class=>"edit_delete "+cls} do
      de = content_tag :span, "",{class: 'icon del', el_id: element.id}
    end
  end

  def td_edit_delete(element,subcount = nil)
    content_tag :td,{:class=>"edit_delete"} do
     #ed = link_to "", edit_polymorphic_path(element), :class=>"icon icon_edit"
     ed = link_to image_tag('edit.png'), edit_polymorphic_path(element) 
     subcount ||= 0
     if subcount>0 
      de = image_tag('delete-disabled.png')
     else
      de = link_to image_tag('delete.png'), element, method: :delete, data: { confirm: 'Действительно удалить -?' }
     end 
     ed + de
    end
  end

  def sp_edit_delete(element,subcount = nil)
    content_tag :td,{:class=>"edit_delete"} do
     #ed = link_to "", edit_polymorphic_path(element), :class=>"icon icon_edit"
     #ed = link_to image_tag('edit.png'), polymorphic_path(element), :class=>"icon icon_edit", data: { modal: true }
      ed = content_tag :span, "",{class: 'icon edit', item_id: element.id}
     subcount ||= 0
     if subcount>0 
      de = content_tag("span","",{:class=>'icon delete disabled'})
     else
      de = content_tag("span","",{:class=>'icon delete', item_id: element.id})
     end 
     ed + de
    end
  end


  def option_link( page,title )
    css_class = @page_data == page ? "active" : nil
    link_to title, '#',{:class =>"list-group-item #{css_class}", :controller => page}
  end


  def option_li( page,title )
    css_class = @page_data == page ? "active" : nil
    content_tag :li, {:class =>css_class } do
      link_to title, '#',{:class =>"list-group-item #{css_class}", :controller => page}
    end
  end

  def new_item_header( cls )
  case cls
    when "Element"
      "Новый элемент"
    when "Whouse"
      "Новый склад"
    else
      cls
    end
  end

  def list_header( cls )
  case cls
    when "Element"
      "Список элементов"
    when "Whouse"
      "Список складов"
    else
      cls
    end
  end

  def short_name(txt)
  	if txt.length >130
  		txt[0..130]+' ...'
  	else
  		txt
  	end
  	
  end

  BOOTSTRAP_FLASH_MSG = {
    success: 'alert-success',
    error: 'alert-error',
    alert: 'alert-block',
    flash_notice: 'alert-info'
  }

  def bootstrap_class_for(flash_type)
    BOOTSTRAP_FLASH_MSG.fetch(flash_type, flash_type.to_s)
  end


  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert flash_#{msg_type} fade-in") do 
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message 
            end)
    end
    nil
  end

end
