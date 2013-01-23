require 'spec_helper'
require 'm1_global_spec_actions'

describe 'resume_spec_tests' do

	describe 'resume actions  from MY PROFILE TAB', :js => true do
		it 'should check that navigating to /resume/add/ will redirect to login' do
			start_session
			visit_homepage
			navigate_directly_to_resume_add
			verify_login_page
		end

		it 'should check that navigating to /resume/upload/ will redirect to login' do
			#start_session
			visit_homepage
			navigate_directly_to_resume_upload
			verify_login_page
		end

		it 'should check link create a new resume ' do
			visit_homepage
			login_user
			navigate_through_my_profile_to_resume_add_update
			verify_create_new_resume
			logout_user

		end

		it 'should be able to upload a resume and save' do
			visit_homepage
			login_user
			navigate_through_my_profile_to_resume_add_update
			upload_my_resume
			add_a_resume
			delete_added_resume
			logout_user
		end
		
		it 'should check for flash message on bad submission' do
			visit_homepage
			login_user
			navigate_through_my_profile_to_resume_add_update
			verify_add_resume
			verify_add_resume_submission
			logout_user
		end
	end

	describe 'resume actions UPLOAD TAB', :js => true do

		it 'should be able to upload a resume and save' do
			visit_homepage
			login_user
			visit_homepage
			navigate_through_upload_resume_to_resume_add_update
			logout_user
		end

		it 'should check link create a new resume ' do
			visit_homepage
			login_user
			navigate_through_my_profile_to_resume_add_update
			verify_create_new_resume
			logout_user

		end
		
	end


end
