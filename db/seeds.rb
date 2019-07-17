# frozen_string_literal: true

contacts = FactoryBot.create_list(:contact, 5)
activities = FactoryBot.create_list(:activity, 5)
contacts_with_activities = FactoryBot.create_list(:contact_with_activities, 5)

user = FactoryBot.create(:user, email: 'example@mail.com' , password: 'password')
