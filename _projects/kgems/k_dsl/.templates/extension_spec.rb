# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::{{camel blueprint.settings.output_rel_path}}::{{camel blueprint.settings.name}} do

  context 'fake document' do
    class FakeDocument; attr_accessor :resource; end

    context 'extension not loaded' do
      subject { document }

      let(:document) { FakeDocument.new }

      it { is_expected.not_to respond_to(:{{snake blueprint.settings.name}}) }

      context 'after extension loaded' do
        before { FakeDocument.include(KDsl::{{camel blueprint.settings.output_rel_path}}::{{camel blueprint.settings.name}}) }

        it { is_expected.to respond_to(:{{snake blueprint.settings.name}}) }

        describe '#{{snake blueprint.settings.name}}' do
          subject { document.{{snake blueprint.settings.name}} nil }
    
          context 'when document not linked to a project' do
            it 'will print a warning log message' do
              expect(document).to receive(:warn).with('Run command skipped: Document not linked to a project')
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
    let(:microapp1) do
      KDsl.microapp('app1') do
        settings do
          app_path "#{Dir.getwd}/spec/.output/abc"
        end
      end
    end

    context 'run a command' do
    end
  end
end
