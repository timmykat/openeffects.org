class CompaniesController < ApplicationController

  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  def index
    @companies = Company.all
  end
  
  def show
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    
    if @company.save
      redirect_to @company, notice: '#{@company.name} was successfully saved.'
    else
      render action: 'new'
    end
  end

  def update
    if @company.update(company_params)
      redirect_to @company, notice: '#{@company.name} was successfully updated.'
    else
      render action: 'new'
    end
  end

  def destroy
    name = @company.name
    @company.destroy
    redirect_to companies_url, notice: '#{name} was successfully deleted.'
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def company_params
      params[:company]
    end
end
