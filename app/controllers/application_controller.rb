class ApplicationController < ActionController::API
  include Pagy::Backend

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from ArgumentError, with: :invalid_argument

  private

  def record_not_found(exception)
    render json: {
      error: 'Not Found',
      message: exception.message
    }, status: :not_found
  end

  def parameter_missing(exception)
    render json: {
      error: 'Bad Request',
      message: exception.message
    }, status: :bad_request
  end

  def invalid_argument(exception)
    render json: {
      error: 'Invalid Parameter',
      message: exception.message
    }, status: :unprocessable_entity
  end
end
