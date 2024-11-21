module ApplicationHelper

  def page_entries_info(collection)
    return unless collection.total_pages > 1

    start_count = (collection.current_page - 1) * collection.limit_value + 1
    end_count = [start_count + collection.limit_value - 1, collection.total_count].min

    "Mostrando #{start_count} até #{end_count} de #{collection.total_count} registros"
  end

end
