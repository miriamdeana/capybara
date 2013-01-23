require 'spec_helper'
require 'm1_global_spec_actions'


describe 'testing ' do 
	describe 'Testing job apply' , :js => true do
		# it 'should check for flash message on bad submission' do
		# 	visit_homepage
		# 	login_user
		# 	navigate_through_my_profile_to_resume_add_update
		# 	verify_add_resume
		# 	verify_add_resume_submission
		# 	logout_user
		# end
	   #  it 'should click each tab' do
	   #  	start_session
	   #    visit_homepage
	   #    save_this_search
	  	# end

	  	it 'should be able to upload a resume and save' do
			visit_homepage
			login_user
			navigate_through_my_profile_to_resume_add_update
			upload_my_resume
			add_a_resume
			delete_added_resume
			logout_user
		end
		# it 'should be able to edit profile info' do
	 #      start_session
	 #      # visit_login_page
	 #      login_user
	 #      edit_my_profile
	 #      verify_successful_edit
	 #      logout_user
	 #    end
	end
	
	
end