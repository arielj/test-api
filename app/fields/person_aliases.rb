class PersonAliases < Trestle::Form::Field
  def field
    content_tag :div, class: 'person_aliases' do
      fs = (builder.object.send(name)+['']).map do |al|
        content_tag :div, class: 'input-group' do
          template.tag :input, type: 'text', name: 'person[aliases][]', value: al, class: 'form-control'
        end
      end
      a = content_tag :a, id: 'add_alias' do
        'Add Alias'
      end
      fs << a
      safe_join fs, ''
      end
  end
end
