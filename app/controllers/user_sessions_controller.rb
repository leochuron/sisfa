class UserSessionsController < ApplicationController
  def new
    # if current_user
    #   redirect_to :controller => :clientes, :action => :new
    # end
  end

  def create 
    if @user = login(params[:username], params[:password])
      if @user.suspendido
        logout
        redirect_to login_path
        flash[:error] = "Usuario suspendido"
      else
        if @user.rol == Rol.administrador_estadistica
          redirect_to new_historia_clinica_path
          flash[:notice] = "Bienvenido #{current_user.username}"
        else
          redirect_to productos_alerta_path
          flash[:notice] = "Bienvenido #{current_user.username}"
        end
      end
    else
      flash[:error] = "Usuario o contraseña inválido"
      redirect_to login_path
    end
  end

  def destroy
    logout
    redirect_to login_path, notice: "Has Cerrado Sesión"
  end
end
