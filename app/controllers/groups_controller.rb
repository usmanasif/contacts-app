class GroupsController < ApplicationController
  before_action :authenticate_user!


  def index
    @groups = current_user.groups.includes(:contacts)
    @group = @groups.build
  end


  def create
    current_user.groups.create!(group_params)

    redirect_to :back, flash: {success: 'Group created!'}
  end


  def edit
    @group = current_user.groups.find params[:id]
    @contacts = current_user.contacts.to_a
    @group_contacts = @group.contacts_groups.includes(:contact).to_a

    @contacts -= @group.contacts.to_a
  end


  def update
    return redirect_to(:back, flash: {info: 'Nothing to update!'}) if params[:group].blank?

    @group = current_user.groups.find params[:id]

    @group.update! group_params

    redirect_to :back, flash: {success: 'Group updated!'}
  end


  def destroy
    group = current_user.groups.find params[:id]

    group.destroy!

    redirect_to :back, flash: {success: 'Group deleted!'}
  end


private
  def group_params
    params.require(:group).permit(:name, contacts_groups_attributes: [:id, :contact_id, :group_id, :_destroy])
  end
end
