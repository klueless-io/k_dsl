# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Manage::Project do
  # puts File.dirname(File.dirname(File.absolute_path(__FILE__)))
  # puts File.dirname __dir__
  # puts File.join( File.dirname(__dir__), 'bin')

  # spec = Gem::Specification.find_by_name("k_dsl").gem_dir
  # puts spec.gem_dir

  let(:gem_root) { Gem::Specification.find_by_name("k_dsl").gem_dir }
  let(:project) { described_class.new(name, config) }
  let(:name) { 'app_name' }
  let(:config) do
    KDsl::Manage::ProjectConfig.new do |c|
      c.base_resource_path = File.join(Dir.getwd, 'spec', 'factories', 'dsls')
    end
  end
  let(:resource) { KDsl::Resources::Resource.instance(project: project, file: file) }
  let(:document1) { KDsl::Model::Document.new :xmen }
  let(:document2) { KDsl::Model::Document.new :xmen, :model }
  let(:document3) { KDsl::Model::Document.new :xmen, :model, namespace: :child }
  let(:document4) { KDsl::Model::Document.new :ymen }
  let(:document) { document1 }
  let(:file) { 'a.txt' }

  describe '#constructor' do
    describe '.name' do
      subject { project.name }

      it { is_expected.to eq(name) }
    end

    describe '.config' do
      subject { project.config }

      it { is_expected.not_to be_nil }
    end

    describe '.watch_paths' do
      subject { project.watch_paths }

      it { is_expected.to be_empty }
    end

    describe '.watch_path_patterns' do
      subject { project.watch_path_patterns }

      it { is_expected.to be_empty }
    end

    describe '.manager' do
      subject { project.manager }

      it { is_expected.to be_nil }
    end

    describe '.managed?' do
      subject { project.managed? }

      it { is_expected.to be_falsey }
    end
  end

  describe '#watch_path' do
    describe '.watch_paths' do
      subject { project.watch_paths }

      context 'when one valid path' do
        before { project.watch_path('ruby_files/*.rb') }

        it { is_expected.to eq [File.join(gem_root, 'spec/factories/dsls/ruby_files')] }

        describe '.watch_path_patterns' do
          subject { project.watch_path_patterns }
          it { is_expected.to eq ['ruby_files/*.rb'] }
        end
      end

      context 'when configured via &block' do
        let(:project) do
          described_class.new(name, config) do
            watch_path('ruby_files/*.rb')
          end
        end

        it { is_expected.not_to be_empty }
      end  
  
      context 'when two parent paths' do
        before do
          project.watch_path('common-auth/*.rb')
          project.watch_path('microapp1/*.rb')
        end

        it do
          expect(subject).to eq [
            File.join(gem_root, 'spec/factories/dsls/common-auth'),
            File.join(gem_root, 'spec/factories/dsls/microapp1')
            ]
        end

        describe '.watch_path_patterns' do
          subject { project.watch_path_patterns }
          it { is_expected.to eq ['common-auth/*.rb', 'microapp1/*.rb'] }
        end
      end

      context 'when deep nested paths' do
        before do
          project.watch_path('microapp2/**/*.rb')
        end

        it do
          expect(subject).to eq [
            File.join(gem_root, 'spec/factories/dsls/microapp2/auth'),
            File.join(gem_root, 'spec/factories/dsls/microapp2')
            ]
        end

        describe '.watch_path_patterns' do
          subject { project.watch_path_patterns }

          it { is_expected.to eq ['microapp2/**/*.rb'] }
        end
      end
    end

    describe '.resources' do
      subject { project.resources }

      context 'when simple ruby files' do
        before { project.watch_path('ruby_files/*.rb') }

        it do
          expect(subject).to include(
            have_attributes(file: File.join(gem_root, 'spec/factories/dsls/ruby_files/ruby1.rb'), resource_type: 'ruby'),
            have_attributes(file: File.join(gem_root, 'spec/factories/dsls/ruby_files/ruby2.rb'), resource_type: 'ruby'),
            have_attributes(file: File.join(gem_root, 'spec/factories/dsls/ruby_files/ruby3.rb'), resource_type: 'ruby')
          )
        end
      end
      context 'when ingore pattern is used' do
        before { project.watch_path('ruby_files/*.rb', ignore: /ruby3.rb$/) }

        it do
          expect(subject).to include(
            have_attributes(file: File.join(gem_root, 'spec/factories/dsls/ruby_files/ruby1.rb'), resource_type: 'ruby'),
            have_attributes(file: File.join(gem_root, 'spec/factories/dsls/ruby_files/ruby2.rb'), resource_type: 'ruby')
          )
          expect(subject).not_to include(
            have_attributes(file: File.join(gem_root, 'spec/factories/dsls/ruby_files/ruby3.rb'), resource_type: 'ruby')
          )
        end
      end

      context 'when multiple paths have files' do
        before do
          project.watch_path('common-auth/*.rb')
          project.watch_path('microapp1/*.rb')
        end

        it do
          expect(subject).to include(
            have_attributes(file: File.join(gem_root, 'spec/factories/dsls/common-auth/admin_user.rb'), resource_type: 'ruby'),
            have_attributes(file: File.join(gem_root, 'spec/factories/dsls/common-auth/basic_user.rb'), resource_type: 'ruby'),
            have_attributes(file: File.join(gem_root, 'spec/factories/dsls/microapp1/domain.rb'), resource_type: 'ruby'),
            have_attributes(file: File.join(gem_root, 'spec/factories/dsls/microapp1/microapp.rb'), resource_type: 'ruby'),
            have_attributes(file: File.join(gem_root, 'spec/factories/dsls/microapp1/structure.rb'), resource_type: 'ruby')
          )
        end
      end

      context 'when deep nested paths have files' do
        before do
          project.watch_path('microapp2/**/*.rb')
        end

        it do
          expect(subject).to include(
            have_attributes(file: File.join(gem_root, 'spec/factories/dsls/microapp2/auth/admin_user.rb'), resource_type: 'ruby'),
            have_attributes(file: File.join(gem_root, 'spec/factories/dsls/microapp2/auth/basic_user.rb'), resource_type: 'ruby'),
            have_attributes(file: File.join(gem_root, 'spec/factories/dsls/microapp2/domain.rb'), resource_type: 'ruby'),
            have_attributes(file: File.join(gem_root, 'spec/factories/dsls/microapp2/microapp.rb'), resource_type: 'ruby'),
            have_attributes(file: File.join(gem_root, 'spec/factories/dsls/microapp2/structure.rb'), resource_type: 'ruby')
          )
        end
      end
    end
  end

  describe '#register_file_resource' do
    describe '.resources' do
      subject { project.resources }

      context 'when using relative files' do
        before { project.register_file_resource('ruby_files/ruby1.rb') }
        
        it { is_expected.to include( have_attributes(file: File.join(gem_root, 'spec/factories/dsls/ruby_files/ruby1.rb'), resource_type:  'ruby')) }
      end

      context 'when using absolute files' do
        before { project.register_file_resource(File.join(gem_root, 'spec/factories/dsls/ruby_files/ruby1.rb'), path_expansion: false) }
        
        it { is_expected.to include( have_attributes(file: File.join(gem_root, 'spec/factories/dsls/ruby_files/ruby1.rb'), resource_type: 'ruby')) }
      end

      context 'when file does not exist' do
        before { project.register_file_resource('bad_file_name.rb') }
        
        it { is_expected.to be_empty }
      end
    end

    # describe '.current_state' do
    #   subject { project.current_state }

    #   before { allow(project).to receive(:process_code) }

    #   context 'on register_file_resource' do
    #     before { project.register_file_resource('ruby_files/ruby1.rb') }

    #     it 'will transition through :register_file_resource' do
    #       project = spy('project')

    #       expect(project).to have_received(:current_state=).with(:register_file_resource)
    #       expect(subject).to eq(:dynamic)
    #       # expect(project).to receive(:current_state).with(:process_code)
    #     end
    #   end
    # end
  end

  describe '#add_resource_document' do
    it '.resource_documents are empty' do
      expect(project.resource_documents.length).to eq 0
    end

    context 'with resource, document' do
      subject { project.add_resource_document(resource, document) }

      let(:document) { document1 }

      it 'returns resource_document' do
        expect(subject).to have_attributes(
          status: resource.status,
          project: resource.project,
          source: resource.source,
          resource_type: resource.resource_type,
          file: resource.file,
          watch_path: resource.watch_path,
          content: resource.content,
          relative_watch_path: resource.relative_watch_path,
          filename: resource.filename,
          base_resource_path: resource.base_resource_path,
          base_resource_path_expanded: resource.base_resource_path_expanded,
          error: document.error,
          unique_key: document.unique_key,
          key: document.key,
          type: document.type,
          namespace: document.namespace,
          options: document.options,
          data: document.data)
      end

    end

    describe '.resource_documents' do
      subject { project.resource_documents }

      it 'add a document' do
        project.add_resource_document(resource, document1)
        expect(subject.length).to eq 1
      end

      it 'add the same document many times' do
        project.add_resource_document(resource, document2)
        project.add_resource_document(resource, document2)
        expect(subject.length).to eq 1
      end

      it 'add many documents' do
        project.add_resource_document(resource, document1)
        project.add_resource_document(resource, document2)
        project.add_resource_document(resource, document3)
        expect(subject.length).to eq 3
      end
    end
  end

  describe 'get_resource_document' do
    subject { project.get_resource_document(document.key, document.type, document.namespace) }

    let(:document) { document3 }

    before { resource.add_document(document) }

    it { expect(subject).not_to be_nil }
    it { expect(subject.document).not_to be_nil }
    it { expect(subject.document.unique_key).to eq(document.unique_key) }
  end

  describe 'resource_document_exist?' do
    before { resource.add_document(document) }

    context 'when key exists' do
      subject { project.resource_document_exist?(:xmen, :entity, '') }

      it { is_expected.to eq(true) }
    end

    context 'when key does not exists' do
      subject { project.resource_document_exist?(:xmen, :entity, 'unknown_namespace') }

      it { is_expected.to eq(false) }
    end
  end

  describe 'get_resource_documents_by_type' do
    before do
      resource.add_document(document1)
      resource.add_document(document2)
      resource.add_document(document3)
      resource.add_document(document4)
    end

    context 'for default type' do
      subject { project.get_resource_documents_by_type }

      # fit do
      #   project.resource_documents.each(&:debug)
      # end

      it 'returns resource_documents of type :entity' do
        expect(subject.length).to eq 2
        expect(subject).to all(have_attributes(type: :entity))
      end
    end

    context 'for custom type' do
      subject { project.get_resource_documents_by_type(:model) }

      it 'returns resource_documents of type :model' do
        expect(subject.length).to eq 2
        expect(subject).to all(have_attributes(type: :model))
      end

      context 'with namespace' do
        subject { project.get_resource_documents_by_type(:model, :child) }

        it 'returns resource_documents of type :model' do
          expect(subject.length).to eq 1
          expect(subject).to all(have_attributes(namespace: 'child'))
        end
      end
    end
  end

end
