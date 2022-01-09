class Dashboard::PaymentMethodsController < ApplicationController
  before_action :set_payment_method, only: %w[show edit update destroy]
  before_action :check_user_authority, except: :index
  layout "dashboard/dashboard"
  
  def index
    @payment_methods = PaymentMethod.all
    @payment_method = PaymentMethod.new
  end
  
  def create
    @payment_method = PaymentMethod.new(payment_method_params)
    if @payment_method.save
      redirect_to dashboard_payment_methods_path, notice: '登録完了'
    else
      flash[:alert] = @payment_method.errors.full_messages
      redirect_back(fallback_location: dashboard_payment_methods_path)
    end
  end
  
  def edit
  end
  
  def update
    if @payment_method.update(payment_method_params)
      redirect_to dashboard_payment_methods_path, notice: '変更完了'
    else
      flash[:alert] = @payment_method.errors.full_messages
      redirect_back(fallback_location: dashboard_payment_methods_path)
    end
  end
  
  def destroy
    @payment_method.destroy
    redirect_to dashboard_payment_methods_path
  end
  
  private
  
  def set_payment_method
    @payment_method = PaymentMethod.find(params[:id])
  end
  
  def payment_method_params
    params.require(:payment_method).permit(:name)
  end
  
  def check_user_authority
    @user = current_user
    if @user.authority.eql?("2")
      flash[:alert] = "権限がありません"
      redirect_to dashboard_path
    end
  end
  
end