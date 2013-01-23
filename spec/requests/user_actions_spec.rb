require 'spec_helper'
require 'm1_global_spec_actions'

describe 'user actions' do

    describe 'login actions', :js => true do
      it 'should prompt user to enter missing fields' do
        start_session
        visit_homepage
        visit_login_page
        login_with_no_password_fail 
      end

      it 'should prompt Invalid Username/Password' do
        start_session
        visit_homepage
        login_user_fail 
      end

      it 'should login logout user' do
        start_session 
        visit_homepage
        login_user
        logout_user
      end
    end

    describe 'register actions', :js => true do
      it "should try existing user and then register unsuccessfully and successfully" do
        start_session
        visit_register_page
        register_existing_user
        do_not_complete_register_info
        complete_register_info
      end
    end   

  describe 'search actions', :js => true do
    it 'should search by keyword locations and also check the next and prev link' do
      start_session
      visit_homepage
      search_by_keyword_location_jobs
      next_previous_link
    end

    it 'should unsuccessfully and then successfully search by moc code from homepage and moc page' do
      start_session
      visit_moc_page
      do_not_search_by_moc
      search_by_moc
      visit_homepage
      search_by_moc
      display_search_by_moc_results
    end

    it 'should browse by SEO Title, State & City' do
      start_session
      visit_browse_page
      browse_by_title
      push_back_browser_arrow
      push_back_browser_arrow
      browse_by_state_then_city
    end

    #Search by Category,city,state,company and pay
    it 'should select an item from each option refine this search' do
      start_session
      visit_homepage
      refine_search_main_page
    end
  end

  describe 'profile edit ', :js => true do
      
    it 'should unsuccessfully and successfully edit profile' do
      start_session
      login_user
      visit_edit_page
      do_not_edit_my_profile
      edit_my_profile
      logout_user
    end
  end
end

