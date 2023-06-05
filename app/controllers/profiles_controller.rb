class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @profile = current_user.profile
  end

  def edit
    # if curent_user.profile.present?
    #   @profile = curent_user.profile
    # else
    #   @profile = current_user.build_profile
    # end
    @profile = current_user.profile || current_user.build_profile
  end

  def update
    @profile = current_user.profile || current_user.build_profile
    @profile.assign_attributes(profile_params)
    if @profile.save
      redirect_to profile_path, notice: 'プロフィール更新'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end

  # updateのためにストロングパラメータを取得する必要がある。
  private
  def profile_params
    params.require(:profile).permit(
      :name,
      :division,
      :description,
      :subscribed,
      :avatar
    )
  end
end