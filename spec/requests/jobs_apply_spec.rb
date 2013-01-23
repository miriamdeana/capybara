require 'spec_helper'
require 'm1_global_spec_actions'


describe 'User_apply_spec_tests' do
  describe 'internal_apply_actions', :js => true do

    it 'should successfully apply logged in user to internal apply job with skins' do 
      start_session
      visit_homepage
      login_user
      search_for_internal_apply_job_with_skins
      select_job
      apply_to_job
      check_for_screener
      logout_user
    end

    it 'should successfully apply logged in user to internal apply job without skins' do
      start_session
      visit_homepage
      login_user
      search_for_internal_apply_job_without_skins
      select_job
      apply_to_job
      check_for_screener
      logout_user
    end

    it 'should successfully apply logged out user to an internal apply job with skins' do
      start_session
      visit_homepage
      search_for_internal_apply_job_with_skins
      select_job
      apply_to_job
      check_for_screener
      logout_user
    end

  end

  describe 'external_apply_actions', :js => true do
    it 'should not apply logged in user due to incomplete info' do
      start_session
      visit_homepage
      search_for_internal_apply_job_without_skins
      select_job
      apply_to_job
      check_for_screener(fail=true)
      verify_required_message
    end

    it 'should successfully apply logged in user to an external apply job without skins' do
      start_session
      visit_homepage
      login_user
      search_for_external_apply_job_without_skins
      select_job
      apply_to_job
      check_for_screener
      logout_user
    end

    it 'should successfully apply logged in user to an external apply job with skins' do
      start_session
      visit_homepage
      login_user
      search_for_external_apply_job_with_skins
      select_job
      apply_to_job
      check_for_screener
      logout_user
    end

    it 'should successfully apply logged out user to an external apply job with skins' do
      start_session
      visit_homepage
      search_for_external_apply_job_with_skins
      select_job
      apply_to_job
      check_for_screener
    end
  end
end
  


