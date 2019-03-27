class MoviePeopleAs < Trestle::Form::Field
  def field
    content_tag :div, class: 'input-group' do
      ops = template.options_from_collection_for_select(Person.all, :id, :to_label, builder.object.send(name).pluck(:id))
      template.select_tag "movie[#{name}_ids][]", ops, prompt: "No #{name}", multiple: true, class: 'form-control'
    end
  end
end
