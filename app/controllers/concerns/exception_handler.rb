module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    %w[ActiveRecord::RecordInvalid ActiveRecord::RecordNotFound PaginationHandler::PaginationError].each do |exception|
      rescue_from(exception) do |error|
        render json: { error: error }, status: :unprocessable_entity
      end
    end
  end
end
