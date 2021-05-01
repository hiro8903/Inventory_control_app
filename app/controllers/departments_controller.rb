class DepartmentsController < ApplicationController

  def index
    @departments = Department.all
  end
  
  def new
    @department = Department.new
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      flash[:success] = "#{@department.name}を作成しました。"
      redirect_to departments_url
    else
      render 'new'
    end
  end

  def edit
    @department = Department.find(params[:id])
  end

  def update
    @department = Department.find(params[:id])
    initial_dapartment_name = @department.name
    if @department.update_attributes(department_params)
      if @department.name != initial_dapartment_name
        flash[:success] = "部署情報を更新しました。"
      else
        flash[:warning] = "変更はありません。"
      end
      redirect_to departments_url
    else
      render 'edit'
    end
  end
  
  def destroy
    department = Department.find(params[:id]).destroy
    flash[:success] = "#{department.name}を削除しました。"
    redirect_to departments_url
  end
  
  


  private

    def department_params
      params.require(:department).permit(:name)      
    end
    
    # beforeアクション

    # # ログイン済みユーザーかどうか確認
    # def logged_in_user
    #   unless logged_in?
    #     store_location
    #     flash[:danger] = "ログインしてください。"
    #     redirect_to login_url
    #   end
    # end

    # # 正しいユーザーかどうか確認
    # def correct_user
    #   @user = User.find(params[:id])
    #   unless current_user?(@user)
    #     flash[:danger] = "他のユーザーページへはアクセスできません。"
    #     redirect_to(root_url) 
    #   end
    # end
  
end
