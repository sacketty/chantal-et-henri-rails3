module ApplicationHelper
  def sortable(col, title = nil)
    column = col.to_s
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(sort: column, direction: direction, page: nil), {class: css_class}
  end
end
