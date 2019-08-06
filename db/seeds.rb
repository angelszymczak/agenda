# frozen_string_literal: true

contacts = FactoryBot.create_list(:contact, 5)
activities = FactoryBot.create_list(:activity, 5)
contacts_with_activities = FactoryBot.create_list(:contact_with_activities, 5)

#user = FactoryBot.create(:user, email: 'example@mail.com' , password: 'password')
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?