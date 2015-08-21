class ContactsController < ApplicationController
  before_action :authenticate_user!


  def index

    respond_to do |format|
      format.html do
        @contacts = current_user.contacts
        @contact = current_user.contacts.build
      end

      format.json do
        render json: ContactsDatatable.new(view_context)
      end
    end
  end


  def create
    @contact = current_user.contacts.create(contact_params)

    if @contact.errors.any?
      @contacts = current_user.contacts
      render :index

    else
      redirect_to :back, flash: {success: 'Contact created!'}
    end
  end


  def edit
    @contact = current_user.contacts.find params[:id]
  end


  def update
    @contact = current_user.contacts.find params[:id]

    @contact.update contact_params

    if @contact.errors.any?
      render :edit

    else
      redirect_to :back, flash: {success: 'Contact updated!'}
    end
  end


  def destroy
    contact = current_user.contacts.find params[:id]
    contact.destroy!

    redirect_to :back, flash: {success: 'Contact deleted!'}
  end

private
  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :phone, :company, :image)
  end
end
