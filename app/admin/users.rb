ActiveAdmin.register User do
  permit_params :email

  controller do
    def update
      #@user = User.update(permitted_params[:user])
    end
  end

  form email: 'A custom email' do |f|
    inputs 'Details' do
      input :email
    end
    panel 'Markup' do
      "The following can be used in the content below..."
    end
    actions
  end

end

