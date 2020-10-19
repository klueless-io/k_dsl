# frozen_string_literal: true

require 'spec_helper'

describe 'Researcher connected applications', type: :feature do
  include_context 'portal_subdomain'

  let(:user) { create :user }
  let(:access_token_response) do
    { status: 200,
      body: 'access_token=SOME_TOKEN&scope=read%3Auser&token_type=bearer',
      headers: { 'content-type' => 'application/x-www-form-urlencoded' } }
  end

  before do
    stub_request(:post, 'https://github.com/login/oauth/access_token').to_return(access_token_response)

    login_as(user)
  end

  with_feature(:researcher_connectable_applications, actor: :user) do
    describe 'connecting an application', :js do
      before do
        visit profile_profile_path
      end

      it 'has a link to connect the application' do
        find_button('Connect Application').click
        expect(page).to have_link('Connect', href: authorize_profile_connected_applications_path(provider: 'github'))
      end
    end
  end
end
