Trestle.resource(:people) do
  menu do
    item :people, icon: "fa fa-star"
  end

  # Customize the table columns shown on the index view.
  #
  # table do
  #   column :name
  #   column :created_at, align: :center
  #   actions
  # end

  # Customize the form fields shown on the new/edit views.
  #
  form do |person|
    row do
      col(xs: 4) { text_field :first_name }
      col(xs: 4) { text_field :last_name }
      col(xs: 4) { select :gender, Person.genders_for_select }
    end

    row do
      col(xs: 4) { aliases :aliases }
    end

    row do
      col(xs: 4) { movies_as :movies_as_actor }
      col(xs: 4) { movies_as :movies_as_director }
      col(xs: 4) { movies_as :movies_as_producer }
    end

    # row do
    #   col(xs: 4) {
    #     fields_for :movies_as_director do
    #       collection_select :movie, Movie.all, :id, :title, include_blank: true, label: 'asd'
    #     end
    #   }
    # end
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:person).permit(:name, ...)
  # end
end
