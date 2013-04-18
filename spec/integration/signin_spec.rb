require 'spec_helper'

feature 'Sessions' do
  scenario 'require student number, family name and date of birth' do
    sign_in

    current_path.should eq buses_path

    click_link 'Logout'

    current_path.should eq root_path
    notifications.should have_content 'You have been logged out'

    visit buses_path

    current_path.should eq root_path
    notifications.should have_content 'You need to sign in first'
  end

  scenario 'expire after 4 hours' do
    sign_in

    current_path.should eq buses_path

    visit buses_path

    current_path.should eq buses_path

    Timecop.travel(4.hours.from_now)

    visit buses_path

    current_path.should eq root_path
    notifications.should have_content 'Your session has expired'
  end
end
