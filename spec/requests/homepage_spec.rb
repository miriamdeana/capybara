require 'spec_helper'
require 'm1_global_spec_actions'

describe 'Homepage ' do

  describe 'Homepage functionality', :js => true do
   
    it 'should successfully load the homepage' do
      start_session
      visit_homepage
      verify_homepage
    end

  end
end

