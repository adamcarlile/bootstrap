class BootstrapBreadcrumbs < SimpleNavigation::Renderer::Base

  def render(item_container)
      content_tag(:ul, li_tags(item_container).join(join_with), { id: item_container.dom_id, class: "#{item_container.dom_class} breadcrumb" })
  end

  protected

  def li_tags(item_container)
    item_container.items.inject([]) do |list, item|
      if item.selected?
        if include_sub_navigation?(item)
          list << content_tag(:li, link_to(item.name, item.url, {method: item.method}.merge(item.html_options.except(:class,:id)))) if item.selected?
          list.concat li_tags(item.sub_navigation)
        else
          list << content_tag(:li, item.name, { class: 'active' }) if item.selected?
        end
      end
      list
    end
  end

  def join_with
    @join_with ||= options[:join_with] || ' <span class="divider">/</span> '.html_safe
  end
end
