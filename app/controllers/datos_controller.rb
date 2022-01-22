# require 'rest-client'
# require 'json'

class DatosController < ApplicationController
  before_action :set_dato, 
  # only: %i[ show update destroy ]

  # GET /datos
  def index
    # @datos = Dato.all

    # @datos = HTTParty.get "https://api.workon.law/technical_challenge/get_lawyers"

    
    # @datos[candidates]
    
    url = "https://api.workon.law/technical_challenge/get_lawyers"
    
    @datos = RestClient.get url
    
    # @datos = "HOLA"

    response = JSON.parse @datos.to_str

    # result = response['candidates'][0]['email']

    result = response

    render json:  result
    # render json: @datos
  end

  # GET /datos/1


  def show

    parametros = params[:id]

    render json: parametros

    # @dato = "datos/1"

    # @dato = before_action

    # render json: @dato

  end

  # POST /datos
  def create
    @dato = Dato.new(dato_params)

    if @dato.save
      render json: @dato, status: :created, location: @dato
    else
      render json: @dato.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /datos/1
  def update
    if @dato.update(dato_params)
      render json: @dato
    else
      render json: @dato.errors, status: :unprocessable_entity
    end
  end

  # DELETE /datos/1
  def destroy
    @dato.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dato
      @dato = Dato.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dato_params
      params.require(:dato).permit(:dato1)
    end
end
