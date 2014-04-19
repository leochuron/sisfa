class EmisorsController < ApplicationController
  def new
    unless Emisor.any?
      @emisor = Emisor.new
    else
      @emisor = Emisor.first
    end
  end
  alias_method :edit, :new

  def create
    if Emisor.any?
      respond_with Emisor.update(Emisor.id, emisor_params)
    else
      respond_with :api, Emisor.create(emisor_params)
    end
  end
  alias_method :update, :create

end
