class PersonMoviesAs < Trestle::Form::Field
  def field
    as = name.to_s.gsub('movies_as_','')
    content_tag :div, class: 'input-group' do
      ops = template.options_from_collection_for_select(Movie.all, :id, :title, builder.object.send(name).pluck(:id))
      template.select_tag "person[movies_as_#{as}_ids][]", ops, prompt: "No movies as #{as}", multiple: true, class: 'form-control'
    end
  end
end
