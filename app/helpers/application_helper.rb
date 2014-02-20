module ApplicationHelper
  def form_errors_for(object)
    if object.errors.any?
      content = pluralize object.errors.count, "error", "errores"
      content += link_to "x", "#", :class => "close", :data => {:dismiss => "alert"}
      content += raw "<ul>"
      object.errors.full_messages.each do |msg|
        content += raw content_tag :li, msg
      end
      content += raw "</ul>"
      content_tag :div, id: "error_explanation", :class => "alert alert-error" do
        raw content
      end
    end
  end

  def month_name(date)
    date  = date.to_time
    date.strftime("%B %Y").upcase
  end

  def redondear(number)
    redondeo = number_with_precision(number, precision: 2)
    # numero = "$ " + redondeo
  end
end
