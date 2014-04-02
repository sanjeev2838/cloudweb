module ApplicationHelper
  def date_format(date)
    date.strftime("%d/%m/%Y")
  end

  def link_to_add_fields(name, f, association)
    unless f.object.class== VaccineAge
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
    end
    end
end
