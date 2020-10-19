# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Extensions::GithubLinkable do

  context 'fake document' do
    class FakeDocument; attr_accessor :resource; end

    context 'extension not loaded' do
      subject { document }

      let(:document) { FakeDocument.new }

      it { is_expected.not_to respond_to(:github_linkable) }

      context 'after extension loaded' do
        before { FakeDocument.include(KDsl::Extensions::GithubLinkable) }

        it { is_expected.to respond_to(:github_new_repo) }
        it { is_expected.to respond_to(:github_delete_repo) }

        describe '#github_new_repo' do
          subject { document.github_new_repo nil }
    
          context 'when document not linked to a project' do
            it 'will print a warning log message' do
              expect(document).to receive(:warn).with('New Github Repo skipped: Document not linked to a project')
              subject
            end
          end
        end

        describe '#github_delete_repo' do
          subject { document.github_delete_repo nil }
    
          context 'when document not linked to a project' do
            it 'will print a warning log message' do
              expect(document).to receive(:warn).with('Delete Github Repo skipped: Document not linked to a project')
              subject
            end
          end
        end
      end
    end
  end

  context 'real document' do
    let(:config) do
      KDsl::Manage::ProjectConfig.new do
        base_resource_path = File.join(Dir.getwd, 'spec', 'factories', 'dsls')
      end
    end
    let(:project) { KDsl::Manage::Project.new('app_name', config) }
    let(:resource) { KDsl::Resources::Resource.instance(project: project, file: 'fakeresource.txt') }

    describe '#github_new_repo' do
      let(:document) { KDsl::Model::Document.new :kdsl_test_repo }

      before { resource.add_document(document) }
      before { document.github_delete_repo(document.key) }

      context 'when repo does not exists' do
        subject { document.github_new_repo(document.key, autoopen: false) }

        it { is_expected.not_to be_nil }
        it { is_expected.to have_attributes(full_name: 'klueless-io/kdsl_test_repo' ) }

        context 'when repo exists' do
          describe '#github_new_repo will just return existing repo' do
            it { is_expected.to have_attributes(full_name: 'klueless-io/kdsl_test_repo' ) }
          end
          describe '#github_delete_repo' do
            subject { document.github_delete_repo(document.key) }

            it { is_expected.to be_truthy }
          end
        end
      end
    end
  end
end
