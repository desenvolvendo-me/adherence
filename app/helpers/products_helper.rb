# app/helpers/products_helper.rb
module ProductsHelper
  def status_badge(status)
    color = case status
            when 'active' then 'green'
            when 'inactive' then 'red'
            else 'yellow'
            end

    content_tag :span,
                t("activerecord.attributes.product.statuses.#{status}"),
                class: "px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-#{color}-100 text-#{color}-800"
  end

  def format_time(value, unit)
    number_with_precision(value, precision: 2) + unit
  end
end