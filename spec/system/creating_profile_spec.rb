require 'rails_helper'

RSpec.describe 'creating a profile', type: :system do
  describe 'creating a username' do
    scenario 'successfully creating a username' do
      when_i_visit_the_homepage
      and_i_submit_the_form
      then_i_see_a_success_message
      my_username_is_stored_in_the_database
      and_the_nostr_json_file_contains_my_details
    end
  end

  private

  def when_i_visit_the_homepage
    visit root_path
  end

  def and_i_submit_the_form
    fill_in :username, with: 'jane'
    fill_in :public_key, with: 'npub1wqkvr9k8j23jyuqyym9fcnyxjpxyanujxsmyvpl7kyntcm0meh7qecu2uh'
    click_button 'Register'
  end

  def then_i_see_a_success_message
    expect(page).to have_content('You are now part of this thing of ours.')
  end

  def my_username_is_stored_in_the_database
    expect(User.find_by(username: 'jane').public_key).to eq('npub1wqkvr9k8j23jyuqyym9fcnyxjpxyanujxsmyvpl7kyntcm0meh7qecu2uh')
  end

  def and_the_nostr_json_file_contains_my_details
    visit nostr_json_path
    expect(page).to have_content('{"names":{"jane":"702cc196c792a322700426ca9c4c86904c4ecf9234364607feb126bc6dfbcdfc"}}')
  end
end
