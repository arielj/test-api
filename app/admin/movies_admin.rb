Trestle.resource(:movies) do
  menu do
    item :movies, icon: "fa fa-film"
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
  form do |movie|
    row do
      col(xs: 6) { text_field :title }
      col(xs: 6) { number_field :release_year }
    end

    unless movie.new_record?
      row do
        col(xs: 4) { people_as :actors }
        col(xs: 4) { people_as :directors }
        col(xs: 4) { people_as :producers }
      end
    end
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:movie).permit(:name, ...)
  # end
end
