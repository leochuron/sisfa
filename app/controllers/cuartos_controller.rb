class CuartosController < ApplicationController

	def index
		@cuarto = Cuarto.new
		@cama = Cama.new
		@cuartos = Cuarto.all
		@camas = @cuarto.camas
	end

	def new
		@cuarto = Cuarto.new
	end

	def create
		@cuarto = Cuarto.new(cuarto_params)
		@cuarto.save
    respond_to do |format|
      format.js{
      	@cama = Cama.new
				@camas = @cuarto.camas
      }
    end
	end

	private
	def cuarto_params
		params.require(:cuarto).permit :nombre		
	end
end
