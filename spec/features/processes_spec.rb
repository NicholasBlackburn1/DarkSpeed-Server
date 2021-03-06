require 'rails_helper'

RSpec.feature 'Processes', type: :feature do
  describe 'management' do
    before :all do
      @password = 'password'
      @admin = Admin.new username: 'admin', password: @password
      @admin.save
      ENV["DARKSPEED_HOST"] = 'darkspeed.test'
      ENV["DARKSPEED_PASSWORD"] = Faker::Internet.password
    end

    before :each do
      visit admin_url
      fill_in 'login', with: @admin.username
      fill_in 'password', with: @password
      click_button 'Open Console'
    end


    it 'starts the servers' do
      ['gateway', 'main'].each do |profile|
        click_button "Start the #{profile} server"
        expect(page).to have_content 'Main server'
      end
    end

    it 'stops the servers' do
      ['gateway', 'main'].each do |profile|
        click_button "Stop the #{profile} server"
        expect(page).to have_content 'Main server'
      end
    end
    after :all do
      Fallout.unique.clear
    end
  end
end
