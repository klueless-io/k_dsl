# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConnectedApplicationCommands::Create do
  subject(:create_connected_application) do
    described_class.call(access_token: access_token,
                         identity: identity,
                         provider: provider)
  end

  let(:identity) { create(:user).identity }
  let(:access_token) { 'SOME_TOKEN' }
  let(:provider) { 'github' }
  let(:mock_api_client) { instance_double(ConnectedApplications::GithubClient) }

  before do
    allow(ConnectedApplications).to receive(:build_api_client).and_return(mock_api_client)
    allow(mock_api_client).to receive(:user).and_return(login: 'saygoodbyetomocks')
  end

  context 'with valid params' do
    it { is_expected.to run_successfully }

    it 'creates an connected application' do
      expect { create_connected_application }
        .to change {
              ConnectedApplication.provider_github.where(identity: identity, name: 'saygoodbyetomocks').count
            } .by(1)
    end
  end

  context 'With invalid parameters' do
    let(:identity) {}

    it { is_expected.not_to run_successfully }

    it 'does not create a connected application' do
      expect { create_connected_application }.not_to change(ConnectedApplication, :count)
    end
  end
end
