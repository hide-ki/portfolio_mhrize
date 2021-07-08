class ArmorsController < ApplicationController
  before_action :check_admin
  before_action :set_armor, only: [:edit, :update, :destroy]
  
  def index
    @head_armors = HeadArmor.all
    @body_armors = BodyArmor.all
    @armo_armors = ArmArmor.all
    @waist_armors = WaistArmor.all
    @foot_armors = FootArmor.all
  end

  def new
    @armor = Armor.new
  end

  def create
    @armor = Armor.new(armor_params)
    if @armor.save
      redirect_to new_armor_path, success: "#{@armor.attributes}"
    else
      redirect_to new_armor_path, danger: '装備の作成に失敗しました。'
    end
  end

  def edit; end

  def update
    case @armor.type
    when 'HeadArmor'
      @armor.assign_attributes(head_armor_params)
    when 'BodyArmor'
      @armor.assign_attributes(body_armor_params)
    when 'ArmArmor'
      @armor.assign_attributes(arm_armor_params)
    when 'WaistArmor'
      @armor.assign_attributes(waist_armor_params)
    when 'FootArmor'
      @armor.assign_attributes(foot_armor_params)
    end
    if @armor.save
      redirect_to armors_path, success: '装備を更新しました。'
    else
      flash.now[:danger] = '装備の更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @armor.destroy!
    redirect_to armors_path, success: '装備を削除しました。'
  end


  private

  def set_armor
    @armor = Armor.find(params[:id])
  end

  def armor_params
    params.require(:armor).permit(:type, :name)
  end

  def head_armor_params
    params.require(:head_armor).permit(:type, :name)
  end

  def body_armor_params
    params.require(:body_armor).permit(:type, :name)
  end

  def arm_armor_params
    params.require(:arm_armor).permit(:type, :name)
  end

  def waist_armor_params
    params.require(:waist_armor).permit(:type, :name)
  end

  def foot_armor_params
    params.require(:foot_armor).permit(:type, :name)
  end

  def check_admin
    redirect_to root_path unless current_user.admin?
  end
end
