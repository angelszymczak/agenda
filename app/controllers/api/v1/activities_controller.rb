# frozen_string_literal: true

module Api::V1
  class ActivitiesController < ApiController # rubocop:disable Style/Documentation
    def index
      json_response(contact.activities)
    end

    def create
      activity = contact.activities.create!(activity_params)

      json_response(activity, :created)
    end

    def update
      activity.update!(activity_params)

      json_response(activity)
    end

    def destroy
      activity.destroy!

      json_response({}, :no_content)
    end

    private

    def activity_params
      params.require(:activity).permit(:description)
    end

    def activity
      @activity ||= contact.activities.find(params[:id])
    end

    def contact
      @contact ||= Contact.find(params[:contact_id])
    end
  end
end
