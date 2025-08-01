class ScrappingTableController < ApplicationController
  before_action :set_scrapping_data, only: [:show, :update, :destroy, :process_step, :refetch]

  def create
    @scrapping_data = ScrappingTable.new(scrapping_data_params)
    if @scrapping_data.save
      render json: @scrapping_data, status: :created
    else
      render json: { errors: @scrapping_data.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    render json: ScrappingTable.all
  end

  def show
    render json: @scrapping_data
  end

  def update
    if @scrapping_data.update(scrapping_data_params)
      render json: @scrapping_data
    else
      render json: { errors: @scrapping_data.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @scrapping_data.destroy
    head :no_content
  end

  def refetch
    # simulate request without saving
    # result = ExternalRequestRunner.call(@scrapping_data.request) # implement this service
    render json: result
  end

  def process_step
    case @scrapping_data.processing_status
    when "unprocessed"
      @scrapping_data.update(processing_status: "sp_filterer")
      # FiltererProcessor.call(@scrapping_data) # implement this service
      @scrapping_data.update(processing_status: "filtered")

    when "filtered"
      @scrapping_data.update(processing_status: "sp_conveter")
      # ConverterProcessor.call(@scrapping_data) # implement this service
      @scrapping_data.update(processing_status: "conveter")

    when "conveter"
      @scrapping_data.update(processing_status: "final_response")
    end

    render json: @scrapping_data
  end

  def curl_import
    curl_str = params[:curl]
    parsed_data = CurlParserService.call(curl_str) # You write this service
    scrapping_data = ScrappingTable.create!(
      source_type_key: "curl_import",
      url: parsed_data[:url],
      request: parsed_data,
      response: {},
      processing_status: :unprocessed,
      workspace_id: params[:workspace_id]
    )
    render json: scrapping_data
  end

  private

  def set_scrapping_data
    @scrapping_data = ScrappingTable.find(params[:id])
  end

  def scrapping_data_params
    params.require(:scrapping_data).permit(
      :source_type_key, :url, :response, :filterer_json,
      :conveter_code, :final_clean_response, :processing_status, :workspace_id,
      request: {} # accepts nested JSON
    )
  end
end
