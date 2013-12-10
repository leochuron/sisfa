class ProveedorsController < ApplicationController
	# GET /proveedor
  # GET /proveedors.json
  before_filter :require_login
  def index
    @proveedors = Proveedor.all
  end

  # GET /proveedors/1
  # GET /proveedors/1.json
  def show
  end

  # GET /proveedors/new
  def new
    @proveedor = Proveedor.new
  end

  # GET /proveeodrs/1/edit
  def edit
  end

  # POST /proveedors
  # POST /proveedors.json
  def create
    @proveedor = Proveedor.new(proveedor_params)

    respond_to do |format|
      if @proveedor.save
        format.html { redirect_to @proveedor, notice: 'Proveedor Almacenada.' }
        format.json { render action: 'show', status: :created, location: @proveedor }
      else
        format.html { render action: 'new' }
        format.json { render json: @proveedor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proveedors/1
  # PATCH/PUT /proveedors/1.json
  def update
    respond_to do |format|
      if @proveedor.update(proveedor_params)
        format.html { redirect_to @proveedor, notice: 'Modificacion exitosa.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @proveedor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proveedors/1
  # DELETE /proveedors/1.json
  def destroy
    @articulo.destroy
    respond_to do |format|
      format.html { redirect_to proveedors_url }
      format.json { head :no_content }
    end
  end
  
  private 
    def proveedor_params
      params.require(:proveedor).permit(:nombre_o_razon_social, :direccion, :codigo, :numero_de_identificacion, :telefono, :ciduad, :pais, :representante_legal, :fax)
    end

end
