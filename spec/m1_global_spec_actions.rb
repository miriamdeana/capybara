require 'spec_helper'

def user_email
  'capybarauser@gmail.com'
end

def user_password
  'columbusrocks!'
end

def start_session
	visit '/user/logout'
end


def verify_required_message
  unless page.all('.required_message').blank?
    page.should have_css('.required_message')
  else
    page.should have_content('This is to make the test purposely fail because no message appeared')
  end
end

def verify_flash_notice
  if page.all('#flash_notice').nil? == false
    page.should have_css('#flash_notice')
  else
    page.should have_content('This is to make the test purposely fail because no message appeared')
  end
end

###################################################
### 		HOMEPAGE GLOBAL FUNCTIONS			###
###################################################

def visit_homepage
	visit '/jobs'
end

def verify_homepage
  page.should have_css('#nav')
  page.should have_css('#qsb-table')
  page.should have_css('#M1_quick_links')
  page.should have_css('#PageContainer')
  page.should have_css('#jobresultspage')
  page.should have_css('#searcharea')
  page.should have_css('#militaryTimes-QSB-container')
  page.should have_css('#qsb-jsrform')
  page.should have_css('#facetwrapper')
  page.should have_css('#qsb-search_type-row')
  page.should have_css('#sbSubmit')
  page.should have_css('#jobresultslist')
  page.should have_css('#jobresultsheader')
  page.should have_css('#facet-area')
  page.should have_css('#on_last_page_of_results')
  page.should have_css('#no_search_results')
  page.should have_css('#footer')
end


###################################################
### 		LOGIN/OUT GLOBAL FUNCTIONS			###
###################################################

def visit_login_page
	page.find('#M1navlogin').find('a').click
end

def login_user
	 visit_login_page
	 fill_in 'user_email', :with => user_email
	 fill_in 'user_password', :with => user_password
	 click_button(I18n.t('lg_loginbtn'))
	 page.should have_content(I18n.t('saved_search_search_submit_label'))
end

def logout_user
	if page.has_content?(I18n.t('nv_logout'))
		 page.all('#M1_quick_links')[0].all('li')[5].find('a').click
	end
end

def verify_login_page
	page.should have_css('#user_email')
	page.should have_css('#user_password')
	page.should have_button(I18n.t('lg_loginbtn'))
end

def login_with_no_password_fail 
	fill_in 'user_email', :with => 'capybarausergmail.com'
	fill_in 'user_password', :with => ''
	click_button(I18n.t('lg_loginbtn'))
	page.should have_css('#flash_notice')
	page.should have_content(I18n.t('gb_form_fields_rqd'))
end

def login_user_fail 
	visit_login_page
	fill_in 'user_email', :with => 'capybarauser@gmail.com'
	fill_in 'user_password', :with => 'blahblah'
	click_button(I18n.t('lg_loginbtn'))
	page.should have_css('#flash_notice')
	page.should have_content(I18n.t('lg_page_invalid_credentials'))
end

###################################################
### 		KEYWORD SEARCH FUNCTIONS 			###
###################################################

def search_by_keyword_location_jobs
	page.find('#rdLocationSelect').all('span')[0].click
	page.find('#keyword-container').fill_in 'Keywords', :with => 'Computer'
	page.find('#location-container').fill_in 'Location', :with => 'atlanta'
	page.find('#submit-container').find('#sbSubmit').click
	wait_for_jobresults
	page.should have_css('.saved_search_modal')
end

###################################################
### 		REFINE SEARCH FUNCTIONS  			###
###################################################

def refine_search_main_page
	page.all('#facetwrapper')[0].all('.category')[0].all('#facetNaviconItemSelectBox')[0].click
	page.all('#facetwrapper')[0].all('.category')[1].all('#facetNaviconItemSelectBox')[0].click
	page.all('#facetwrapper')[0].all('.category')[2].all('#facetNaviconItemSelectBox')[0].click
	page.all('#facetwrapper')[0].all('.category')[3].all('#facetNaviconItemSelectBox')[0].click
	page.all('#facetwrapper')[0].all('.category')[4].all('#facetNaviconItemSelectBox')[0].click		
	wait_for_jobresults
	page.should have_css('.saved_search_modal')
end


def next_previous_link
	if page.has_content?(I18n.t('hm_next')) then
		page.all('#m1_searchnext_next_link')[0].click
		if page.has_content?(I18n.t('hm_prev')) then
			page.all('#m1_searchprev_prev_link')[0].click
	    end  
	end	
end

##########################################
####  USER REGISTER GLOBAL FUNCTIONS  ####
##########################################

def visit_register_page
  page.find('.M1navRightOptions').all('a')[1].click
  first('title')[:text] == I18n.t('rg_page_title')
  page.should have_css('#Register.borderbox.formpage')
end

def register_existing_user
  fill_in 'em_1', :with => 'testuser@test.com'
  fill_in 'em_2', :with => 'testuser@test.com'
  fill_in 'pss_1', :with => 'testtest1'
  fill_in 'pss_2', :with => 'testtest1'
  fill_in 'user_first_name', :with =>'Alex'
  fill_in 'user_last_name', :with => 'HristovSucks'
  fill_in 'user_city', :with => 'Chamblee'
  fill_in 'stateField', :with =>'GA'
  fill_in 'zip', :with =>'00000'
  find("option[value='US']").click
  find('.actionrow').click_on 'register'
end

def complete_register_info
  fill_in 'em_1', :with => 'joe@ymail.com'
  fill_in 'em_2', :with => 'joe@ymail.com'
  fill_in 'pss_1', :with => 'passw0rd'
  fill_in 'pss_2', :with => 'passw0rd'
  fill_in 'user_first_name', :with => 'first'
  fill_in 'user_last_name', :with => 'last'
  fill_in 'user_city', :with => 'Philadelphia'
  fill_in 'stateField', :with => 'PA'
  fill_in 'zip', :with => '19141'
  find("option[value='US']").click
  find('.actionrow').click_on 'register'
  page.should have_css('#flash_success_message')
end

def do_not_complete_register_info
  fill_in 'em_1', :with => 'joe@ymail.com'
  fill_in 'em_2', :with => 'joe@ymail.com'
  fill_in 'user_first_name', :with => 'first'
  fill_in 'user_last_name', :with => 'last'
  fill_in 'user_city', :with => 'Philadelphia'
  fill_in 'stateField', :with => 'PA'
  fill_in 'zip', :with => '19141'
  find("option[value='US']").click
  find('.actionrow').click_on 'register'
  page.should have_css('#flash_notice')
  page.should have_content(I18n.t('rg_page_existing_acct'))
end



###################################################
### 		EDIT USER PROFILE FUNCTIONS  		###
###################################################

def visit_edit_page
	page.all('#M1_quick_links')[0].all('li')[4].find('a').click
	page.all('#tab_profile')[0].click
	page.find('#userEditLink').click
end

def verify_edit_page
	page.should have_css('#edit')
end

def edit_my_profile
	page.all('#M1_quick_links')[0].all('li')[4].find('a').click
	page.find('#tab_profile').click
	page.find('#userEditLink').click
	fill_in 'user[password]', :with => 'columbusrocks!'
	fill_in 'user[first_name]', :with => 'Capybara'
	fill_in 'user[last_name]', :with => 'user'
	fill_in 'user[city]', :with => 'Roswell'
	fill_in 'user[state]', :with => 'GA'
	fill_in 'user[zip]', :with => '30092'
	find("option[value='US']").click
	click_button(I18n.t('u_ed_submit_changes'))
	page.should have_css('#flash_success_message')
	page.should have_content(I18n.t('u_ed_success'))
end

def do_not_edit_my_profile
	page.all('#M1_quick_links')[0].all('li')[4].find('a').click
	page.find('#tab_profile').click
	page.find('#userEditLink').click
	click_button(I18n.t('u_ed_submit_changes'))
	page.should have_css('#flash_notice')
	page.should have_content(I18n.t('gb_form_fields_rqd'))
end


###################################################
### 		ADD/UPLOAD RESUME FUNCTIONS  		###
###################################################


def navigate_directly_to_resume_upload
	visit '/resume/upload'
end

def navigate_directly_to_resume_add
	visit '/resume/add'
end

def navigate_through_upload_resume_to_resume_add_update
	page.all('#M1_quick_links')[0].all('li')[3].find('a').click
	if page.has_css?('#user_email') and page.has_css?('#user_password')
		login_user
	end
end

def navigate_through_my_profile_to_resume_add_update
	page.all('#M1_quick_links')[0].all('li')[4].find('a').click
	if page.has_css?('#user_email') and page.has_css?('#user_password')
		login_user
	end
	page.find('#tab_resume').click
	click_link(I18n.t('rw_add_resume') + ' +')
end

def verify_add_resume
	click_link(I18n.t('res_upload_create_resume_link'))
	click_button(I18n.t('res_add_page_create'))
	page.should have_css('#flash_notice')
end


def upload_my_resume	
	fill_in 'title', :with => 'test engineer'
	attach_file('file', Rails.root + 'spec/spec_helper.rb')
	click_button(I18n.t('res_upload_page_upload'))
end

def verify_upload_resume
	page.should have_css(I18n.t('res_upload_create_resume_link'))
end


def verify_create_new_resume_link
	click_link(I18n.t('res_upload_create_resume_link'))
	page.should have_content(I18n.t('res_add_page_h3'))
end

def add_a_resume
	if page.has_content?(I18n.t('res_add_page_h3'))

		fill_in 'resume_title', :with => 'Test Pilot, CB Air force'
		fill_in 'resume_recent_pay_amount', :with => '500.00'
		fill_in 'resume_resume_text', :with => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus nibh augue, faucibus sit amet fringilla eu, ultricies sit amet purus. Aenean quis placerat massa. Aenean ullamcorper quam a dolor eleifend consequat. Duis consequat malesuada tortor, a tempor diam pulvinar nec. Mauris porta blandit magna sed suscipit. Suspendisse varius luctus pulvinar. Donec rutrum iaculis enim, eu consectetur risus pretium et.\n\nVestibulum orci libero, pulvinar sit amet laoreet id, pulvinar quis sapien. Vestibulum ac tortor nisi, eu laoreet purus. Fusce nisl tellus, feugiat et dapibus et, bibendum eu augue. Fusce iaculis, augue eget cursus fringilla, ipsum eros venenatis metus, non lacinia neque mi quis magna. Mauris a purus massa. Suspendisse potenti. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed eleifend fermentum risus, vel pellentesque sapien adipiscing non. In rhoncus dui eget urna placerat sodales.'
	
		# SPOKEN LANGUAGES
		click_link(I18n.t('res_add_language'))
		select('Czech', :from => find('#language_fields').find('select')[:id])

		# EXPERIENCE
		click_link(I18n.t('res_add_experience'))

		# Company Name
		fill_in find('#company_experience_fields').find('.fields').all('p')[0].find('input')[:id], :with => 'CB Aero Force of Good'
		# Job Title
		fill_in find('#company_experience_fields').find('.fields').all('p')[1].find('input')[:id], :with => 'Test Pilot'
		# Start Date
		select '4', :from => find('#company_experience_fields').find('.fields').all('p')[2].all('select')[0][:id]
		select '1997', :from => find('#company_experience_fields').find('.fields').all('p')[2].all('select')[1][:id]
		# End Date
		select '12', :from => find('#company_experience_fields').find('.fields').all('p')[3].all('select')[0][:id]
		select '2012', :from => find('#company_experience_fields').find('.fields').all('p')[3].all('select')[1][:id]
		# Details
		fill_in find('#company_experience_fields').find('.fields').all('p')[4].find('textarea')[:id], :with => 'Ut dignissim scelerisque ante sit amet facilisis. Mauris tincidunt scelerisque tellus eget cursus. Donec a elit quam, ut facilisis nisl. Nullam at sem enim, vel ullamcorper eros. Curabitur rhoncus luctus quam vel malesuada. Sed sed magna tellus. Fusce eleifend, justo eu porta aliquet, mi neque gravida justo, at porttitor nisl massa sollicitudin felis. Maecenas tincidunt, dui dapibus eleifend tempor, erat turpis ultrices nibh, eu blandit nisi massa varius urna. Aliquam diam augue, gravida vitae aliquam nec, gravida sit amet dolor. Pellentesque faucibus mi convallis odio mollis lacinia posuere lorem bibendum. Praesent et leo nisl. Fusce vel tincidunt leo. Integer leo augue, condimentum vel imperdiet nec, tincidunt at dolor. Donec fermentum odio non justo hendrerit placerat. Donec in lorem augue.'

		# EDUCATION
		click_link(I18n.t('res_add_education'))
		# School
		fill_in find('#education_fields').find('.fields').all('p')[0].find('input')[:id], :with => 'College of Awesome'
		# Major
		fill_in find('#education_fields').find('.fields').all('p')[1].find('input')[:id], :with => 'Aviation Sciences'
		# Degree
		select 'Vocational', :from => find('#education_fields').find('.fields').all('p')[2].all('select')[0][:id]
		# Graduation Date
		select '5', :from => find('#education_fields').find('.fields').all('p')[3].all('select')[0][:id]
		select '1978', :from => find('#education_fields').find('.fields').all('p')[3].all('select')[1][:id]

		click_button(I18n.t('res_add_page_create'))

	end  
end

def delete_added_resume
	page.all('#M1_quick_links')[0].all('li')[4].find('a').click
	page.find('#tab_resume').click
	if page.has_css?('#resumetitle') then
		page.all('#resumetitle')[0].find('a').click
		click_link(I18n.t('rw_delete_resume'))
	end
end

############################################################
### 			APPLY GLOBAL FUNCTIONS					 ###
############################################################




def select_job (job=0)
  page.all('.resulttitle')[job].click
  page.should have_css('.applyLinkTest')
end

def apply_to_job
  if page.has_css?('#saveapp')
    page.all('#saveapp')[0].click
  elsif page.has_css?('.applyLinkTest')
    page.all('.applyLinkTest')[0].click
  end
end

def verify_successful_apply
	if page.has_css?('#flash_notice') then	
	  if !page.has_content?(I18n.t('ap_applied_success'))
	    page.should have_content(I18n.t('ap_popup_sent_title'))
	  end
	end
end

def check_for_screener(fail=false)
  if page.has_css?('#job_application_questions_attributes_0_id')
    if (fail == false)
		fill_screener_form
	else
		fill_screener_form_fail
	end
  elsif page.has_css?('#emailcaptureform', :visible => true)
    page.all('#email')[0].set('captainmorgan@gmail.com')
    click_button('emailcapture_submit')
  end 
end

def fill_screener_form
  page.all('#tab_paste')[0].click
	 @field_num = 0
  	loop do 
    	@elementFormat = "#job_application_questions_attributes_#{@field_num}_response"
    	@inputTextFormat = "input#job_application_questions_attributes_#{@field_num}_response"
    	@selectBoxFormat = "select#job_application_questions_attributes_#{@field_num}_response"
    	@fillInFormat = "job_application_questions_attributes_#{@field_num}_response"
    	@textareaFormat = "textarea#job_application_questions_attributes_#{@field_num}_response"

    	# iterate through all the form fields in the application
    	break if page.has_no_css?(@elementFormat)
    	if page.has_css?(@inputTextFormat)
    	  fill_in @fillInFormat, :with => 'capybara test text'
    	elsif page.has_css?(@selectBoxFormat)
    	  within @selectBoxFormat do 
    	    find(:xpath, './/option[2]').click
    	  end
    	$DEBUG = true
    	elsif page.has_css?(@textareaFormat)
    		fill_in @fillInFormat, :with => 'capybara test text'
    	end

    	@field_num += 1
  	end

	page.has_css?('#saveapp')
	apply_to_job

	if page.has_css?('#flash_notice') then	
	  if !page.has_content?(I18n.t('ap_applied_success'))
	    page.should have_content(I18n.t('ap_popup_sent_title'))
	  end
	end
	page.should have_css('#rec_box')
end

def fill_screener_form_fail
	if page.has_css?('#saveapp')
		apply_to_job
	end	
end


def wait_for_jobresults
  @count = 0
  while !page.has_css?('#ajax-success') do
    sleep 1
    @count += 1
    if @count == 3 then 
      break
    end
  end
end

def search_for_internal_apply_job_without_skins
  fill_in 'Keywords', :with => 'customcodes:CBDEV_applyurlno -customcodes:CBDEV_jobskinyes'
  fill_in 'Location', :with => 'Philadelphia, PA'
  find('#sbSubmit').click
  wait_for_jobresults
  page.should have_css('.saved_search_modal')
end

def search_for_internal_apply_job_with_skins
  fill_in 'Keywords', :with => 'customcodes:CBDEV_applyurlno customcodes:CBDEV_jobskinyes'
  fill_in 'Location', :with => 'Atlanta, GA'
  find('#sbSubmit').click
  wait_for_jobresults
  page.should have_css('.saved_search_modal')
end

def search_for_external_apply_job_without_skins
  fill_in 'Keywords', :with => 'customcodes:CBDEV_applyurlyes -customcodes:CBDEV_jobskinyes'
  fill_in 'Location', :with => 'Oakbrook, IL'
  find('#sbSubmit').click
  wait_for_jobresults
  page.should have_css('.saved_search_modal')
end

def search_for_external_apply_job_with_skins
  fill_in 'Keywords', :with => 'customcodes:CBDEV_applyurlyes customcodes:CBDEV_jobskinyes'
  fill_in 'Location', :with => 'New York, NY'
  find('#sbSubmit').click
  wait_for_jobresults
  page.should have_css('.saved_search_modal')
end


##############################################
###       SEARCH/BROWSE GLOBAL FUNCTIONS   ###
##############################################

def visit_moc_page
  find('#M1_quick_links').all('a')[0].click
  page.should have_content(I18n.t('moc_page_h2'))
end

def search_by_moc
  if current_path == '/jobs'
    find('#rdMOC').click
    @branch = [ 'A', 'N', 'af', 'M', 'C', 'ALL' ]
  elsif current_path == '/moccodes'
    @branch = [ 'branch_A', 'branch_N', 'branch_F', 'branch_M', 'branch_C', 'branch_ALL' ]
  end
  @branch.each do |branch|
	  fill_in 'qsb-moccode-input', :with => '0510'
	  choose branch
	  find('#qsb-submit-input').click
	  wait_for_jobresults
	  page.should have_content(I18n.t('moc_page_h2_on_search')) 
	  push_back_browser_arrow 
  end
end 

def do_not_search_by_moc
  fill_in 'qsb-moccode-input', :with => ' '
  find('#qsb-submit-input').click
  page.should have_content(I18n.t('moc_no_code'))  
end

def display_search_by_moc_results
	wait_for_jobresults
    page.all('.olul')[0].all('a')[0].click
end

def visit_browse_page
  find('#M1_quick_links').all('a')[2].click
end

def browse_by_title
  @letter = find('#SEO_By_Title').all('a')[0].text
  find('#SEO_By_Title').all('a')[0].click
  has_content?('Title ' + @letter)
  page.all('.blocklink')[0].find('a').click
  current_url == 'http://jobs.militarytimes.com/jobs?Category=Admin%2520+Clerical'
end

def push_back_browser_arrow
  page.evaluate_script('window.history.back()')
end

def browse_by_state_then_city
  page.find('#SEO_By_State').all('.blocklink')[0].all('a')[0].click
  page.all('.blocklink')[0].find('a').click
end