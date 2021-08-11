# frozen_string_literal: true

require 'csv_processor'

# Users Controller
class UsersController < ApplicationController
  before_action :clear_flash

  def upload; end

  def create
    error_message = CsvProcessor.validate_csv_file(params[:file])
    redirect_to root_path, flash: { error: error_message } and return if error_message.present?

    execute_csv
    render :upload
  end

  def sample_csv
    respond_to do |format|
      format.csv do
        response.headers['Content-Type'] = 'text/csv'
        response.headers['Content-Disposition'] = 'attachment; filename=sample.csv'
      end
    end
  end

  private

  def execute_csv
    @results = CsvProcessor.fetch_and_create_records(params[:file])
    flash[:notice] = 'CSV processing successfully'
  rescue CSV::MalformedCSVError
    flash[:error] = 'Invalid CSV format. Please refer Sample CSV.'
  rescue StandardError => e
    flash[:error] = e.message
  end
end
