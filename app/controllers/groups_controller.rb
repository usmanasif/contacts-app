class GroupsController < ApplicationController
  before_action :authenticate_user!


  def index
    @groups = current_user.groups
    @group = @groups.build
  end


  def create
    current_user.groups.create!(group_params)

    redirect_to :back, flash: {success: 'Group created!'}
  end


  def edit
    @group = current_user.groups.find params[:id]
  end


  def update
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
    params.require(:group).permit(:name)
  end
end
