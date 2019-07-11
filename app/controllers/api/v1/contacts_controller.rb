# frozen_string_literal: true

module Api
  module V1
    class ContactsController < ApiController # rubocop:disable Style/Documentation
      def index
        json_response(Contact.all)
      end

      def create
        contact = Contact.create!(contact_params)

        json_response(contact, :created)
      end

      def show
        json_response(contact)
      end

      def update
        contact.update!(contact_params)

        json_response(contact)
      end

      def destroy
        contact.destroy!

        json_response({}, :no_content)
      end

      private

      def contact_params
        params.require(:contact).permit(:first_name, :last_name, :cell_phone, :zip_code)
      end

      def contact
        @contact ||= Contact.find(params[:id])
      end
    end
  end
end
