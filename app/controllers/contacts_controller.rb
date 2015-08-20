class ContactsController < ApplicationController
  before_action :authenticate_user!


  def index
    @contacts = current_user.contacts
    @contact = current_user.contacts.build
  end


  def create
    current_user.contacts.create!(contact_params)

    redirect_to :back, flash: {success: 'Contact created!'}
  end


private
  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :phone, :company, :image)
  end
end
