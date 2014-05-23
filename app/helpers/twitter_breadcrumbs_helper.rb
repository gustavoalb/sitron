# -*- encoding : utf-8 -*-
module TwitterBreadcrumbsHelper
  def render_breadcrumbs_app(divider = '>', &block)
    content = render :partial => 'shareds/breadcrumbs', :layout => false, :locals => { :divider => divider }
    if block_given?
      capture(content, &block)
    else
      content
    end
  end
end

