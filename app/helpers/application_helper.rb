module ApplicationHelper
  def form_error(model, param)
    if model.errors[param].any?
      content_tag(:span, class: "text-red-500 text-sm") do
        model.errors[param].first
      end
    end
  end
end
