class TestModelsController < ApplicationController
  before_action :set_test_model, only: [:show, :update, :destroy]

  # GET /test_models
  def index
    @test_models = TestModel.all

    render json: @test_models
  end

  # GET /test_models/1
  def show
    render json: @test_model
  end

  # POST /test_models
  def create
    @test_model = TestModel.new(test_model_params)

    if @test_model.save
      render json: @test_model, status: :created, location: @test_model
    else
      render json: @test_model.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /test_models/1
  def update
    if @test_model.update(test_model_params)
      render json: @test_model
    else
      render json: @test_model.errors, status: :unprocessable_entity
    end
  end

  # DELETE /test_models/1
  def destroy
    @test_model.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_model
      @test_model = TestModel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def test_model_params
      params.require(:test_model).permit(:nickname, :status, :description)
    end
end
