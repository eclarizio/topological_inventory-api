module Api
  module V0
    class SourcesController < ApplicationController
      include Api::Mixins::DestroyMixin
      include Api::Mixins::IndexMixin
      include Api::Mixins::ShowMixin

      def create
        source = Source.create!(create_params)
        render :json => source, :status => :created, :location => api_v0x0_source_url(source.id)
      end

      def update
        Source.update(params.require(:id), update_params)
        head :no_content
      rescue ActiveRecord::RecordNotFound
        head :not_found
      end

      private

      def create_params
        ActionController::Parameters.new(JSON.parse(request.body.read)).permit(:name, :tenant_id)
      end

      def update_params
        params.permit(:name)
      end

      def list_params
        params.permit(:tenant_id)
      end

      def model
        Source
      end
    end
  end
end
