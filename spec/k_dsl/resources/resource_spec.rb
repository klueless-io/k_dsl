# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Resources::Resource do
  subject { resource }

  let(:resource) { described_class.instance(project: project, file: file, watch_path: watch_path) }
  let(:project) { KDsl::Manage::Project.new('sample_app') }
  let(:file) { 'a.txt' }

  let(:gem_root) { Gem::Specification.find_by_name("k_dsl").gem_dir }
  # let(:watch_path) { gem_root }
  let(:watch_path) { nil }
  let(:csv_file) { File.join(gem_root, 'spec/factories/dsls/data_files/sample.csv') }
  let(:json_file) { File.join(gem_root, 'spec/factories/dsls/data_files/sample.json') }
  let(:yaml_file) { File.join(gem_root, 'spec/factories/dsls/data_files/sample.yaml') }
  let(:unknown_file) { File.join(gem_root, 'spec/factories/dsls/data_files/sample.xxx') }
  let(:ruby_file) { File.join(gem_root, 'spec/factories/dsls/ruby_files/ruby1.rb') }
  let(:dsl_file1) { File.join(gem_root, 'spec/factories/dsls/simple_dsl/one_dsl.rb') }
  let(:dsl_file2) { File.join(gem_root, 'spec/factories/dsls/simple_dsl/two_dsl.rb') }

  describe '#constructor' do
    it 'is linked to a project' do
      expect(subject.project).not_to be_nil
    end

    context 'when file provided' do
      context 'with any old file' do
        it do
          is_expected.to be_a(KDsl::Resources::Resource).and have_attributes(
            project: be_a(KDsl::Manage::Project),
            document_factory: be_a(KDsl::Resources::Factories::UnknownDocumentFactory),
            file: file,
            type: described_class::TYPE_UNKNOWN,
            source: described_class::SOURCE_FILE,
            watch_path: nil,
            documents: [],
            content: nil,
            error: nil)
        end
      end
  
      context 'with json file' do
        let(:file) { '/somepath/file.json' }
  
        it { is_expected.to have_attributes(file: file, type: described_class::TYPE_JSON, document_factory: be_a(KDsl::Resources::Factories::JsonDocumentFactory)) }
      end
  
      context 'with yaml file' do
        let(:file) { '/somepath/file.yaml' }
  
        it { is_expected.to have_attributes(file: file, type: described_class::TYPE_YAML, document_factory: be_a(KDsl::Resources::Factories::YamlDocumentFactory)) }
      end
  
      context 'with csv file' do
        let(:file) { '/somepath/file.csv' }
        
        it { is_expected.to have_attributes(file: file, type: described_class::TYPE_CSV, document_factory: be_a(KDsl::Resources::Factories::CsvDocumentFactory)) }
      end

      context 'with unknown file' do
        let(:file) { '/somepath/file.xxx' }
        
        it { is_expected.to have_attributes(file: file, type: described_class::TYPE_UNKNOWN, document_factory: be_a(KDsl::Resources::Factories::UnknownDocumentFactory)) }
      end

      context 'with ruby file' do
        let(:file) { ruby_file }
  
        it { is_expected.to have_attributes(file: file, type: described_class::TYPE_RUBY, document_factory: be_a(KDsl::Resources::Factories::RubyDocumentFactory)) }
  
        context 'with Klueless ruby DSL' do
          let(:file) { dsl_file1 }

          # At this point, we are not aware of ruby file contents and so
          # the type has not been altered to TYPE_RUBY_DSL
          it { is_expected.to have_attributes(file: file, type: described_class::TYPE_RUBY, document_factory: be_a(KDsl::Resources::Factories::RubyDocumentFactory)) }
        end
      end
    end
  end
  
  describe '#load_content' do
    subject { resource }

    before { resource.load_content }

    context 'when file does not exist' do
      it do
        is_expected.to have_attributes(
          file: 'a.txt',
          content: be_nil,
          error: be_a(KDsl::Error),
          error: have_attributes(message: "Source file not found: a.txt"))
      end
    end

    context 'when file exists' do
      subject { resource.content }
      let(:file) { csv_file }
      
      it { is_expected.not_to be_nil }
    end

    describe '#register' do
      before { resource.register }
      
      context 'csv' do
        let(:file) { csv_file }
  
        context '.documents' do
          subject { resource.documents }
  
          it { is_expected.not_to be_empty }
          it { expect(subject.length).to eq 1 }
        end

        context '.document[0]' do
          subject { resource.documents[0] }

          it do
            is_expected.to have_attributes(
              key: 'sample.csv',
              type: 'csv',
              namespace: '',
              resource: resource,
              unique_key: 'sample.csv_csv',
              data: {}
            )
          end

          describe '#load' do
            subject { resource.documents[0].data }

            before { resource.load }

            it { is_expected.to include( { name: 'David', title: 'Developer', days_employed: '402' } ) }
            it { is_expected.to include( { name: 'Bob', title: 'Project Manager', days_employed: '289' } ) }
          end
        end
      end

      context 'json' do
        let(:file) { json_file }
  
        context '.documents' do
          subject { resource.documents }
  
          it { is_expected.not_to be_empty }
          it { expect(subject.length).to eq 1 }
        end

        context '.document[0]' do
          subject { resource.documents[0] }

          it do
            is_expected.to have_attributes(
              key: 'sample.json',
              type: 'json',
              namespace: '',
              resource: resource,
              unique_key: 'sample.json_json',
              data: {}
            )
          end

          describe '#load' do
            subject { resource.documents[0].data }

            before { resource.load }

            it { is_expected.to include(
              'name' => 'David',
              'age' => 32,
              'contact' => {
                'phone' => '0424 111 222',
                'email' => 'david@david.com',
                'address' => { 'street' => '32 Main St', 'suburb' => 'Sydney' }
              },
              'skills' => [
                { 'name' => 'javascript', 'proficiency' => 'ok' },
                { 'name' => 'ruby', 'proficiency' => 'good' }
              ]
            )}
          end
        end
      end

      context 'yaml' do
        let(:file) { yaml_file }
  
        context '.documents' do
          subject { resource.documents }
  
          it { is_expected.not_to be_empty }
          it { expect(subject.length).to eq 1 }
        end

        context '.document[0]' do
          subject { resource.documents[0] }

          it do
            is_expected.to have_attributes(
              key: 'sample.yaml',
              type: 'yaml',
              namespace: '',
              resource: resource,
              unique_key: 'sample.yaml_yaml',
              data: {}
            )
          end

          describe '#load' do
            subject { resource.documents[0].data }

            before { resource.load }

            it { is_expected.to include(
              'company' => {
                'name' => 'Klueless','industry' => 'Tech' },
              'employees' => [
                { 'martin' => { 'name' => "Martin D'vloper", 'job' => 'Developer', 'skills' => ['python', 'perl', 'pascal'] } },
                { 'tabitha' => { 'name' => 'Tabitha Bitumen', 'job' => 'Developer', 'skills' => ['lisp', 'fortran', 'erlang'] } }
              ]
            )}
          end
        end
      end

      context 'unknown' do
        let(:file) { unknown_file }
  
        context '.documents' do
          subject { resource.documents }
  
          it { is_expected.not_to be_empty }
          it { expect(subject.length).to eq 1 }
        end

        context '.document[0]' do
          subject { resource.documents[0] }

          it do
            is_expected.to have_attributes(
              key: 'sample',
              type: 'unknown',
              namespace: '',
              resource: resource,
              unique_key: 'sample_unknown',
              data: {}
            )
          end

          describe '#load' do
            subject { resource.documents[0].data }

            before { resource.load }

            it { is_expected.to include({}) }
          end
        end
      end

      context 'ruby' do
        let(:file) { ruby_file }
  
        context '.documents' do
          subject { resource.documents }
  
          it { is_expected.not_to be_empty }
          it { expect(subject.length).to eq 1 }
        end

        context '.document[0]' do
          subject { resource.documents[0] }

          it do
            is_expected.to have_attributes(
              key: 'ruby1',
              type: 'ruby',
              namespace: '',
              resource: resource,
              unique_key: 'ruby1_ruby',
              data: {}
            )
          end

          describe '#load' do
            subject { resource.documents[0].data }

            before { resource.load }

            it { is_expected.to include({}) }
          end
        end
      end

      context 'ruby with one DSL' do
        let(:file) { dsl_file1 }

        before { KDsl.target_resource = resource }
        after { KDsl.target_resource = nil }
  
        context '.documents' do
          subject { resource.documents }
  
          it { is_expected.not_to be_empty }
          it { expect(subject.length).to eq 1 }
        end

        context '.document[0]' do
          subject { resource.documents[0] }

          it do
            is_expected.to have_attributes(
              key: :my_name,
              type: :entity,
              namespace: '',
              resource: resource,
              unique_key: 'my_name_entity',
              data: {}
            )
          end

          describe '#load' do
            subject { resource.documents[0].data }

            before { resource.load }

            it do
              is_expected.to include({
                'settings' => {
                  'a' => "1",
                  'b' => 2
                }
              })
            end
          end
        end
      end

      context 'ruby with two DSLs' do
        let(:file) { dsl_file2 }

        before { KDsl.target_resource = resource }
        after { KDsl.target_resource = nil }
  
        context '.documents' do
          subject { resource.documents }
  
          it { is_expected.not_to be_empty }
          it { expect(subject.length).to eq 2 }
        end

        context '.document[0]' do
          subject { resource.documents[0] }

          it do
            is_expected.to have_attributes(
              key: :my_name1,
              type: :entity,
              namespace: '',
              resource: resource,
              unique_key: 'my_name1_entity',
              data: {}
            )
          end

          describe '#load' do
            subject { resource.documents[0].data }

            before { resource.load }

            it do
              is_expected.to include({
                'settings' => {
                  'rails_port' => 3000,
                  'app_path' => '~/somepath'
                }
              })
            end
          end
        end

        context '.document[1]' do
          subject { resource.documents[1] }

          it do
            is_expected.to have_attributes(
              key: :my_name2,
              type: :entity,
              namespace: '',
              resource: resource,
              unique_key: 'my_name2_entity',
              data: {}
            )
          end

          describe '#load' do
            subject { resource.documents[1].data }

            before { resource.load }

            it do
              is_expected.to include({
                "applets" => 
                  {
                    "fields" => [
                      { "default" => nil, "name" => "name", "type" => "string"},
                      { "default" => true, "name" => "active", "type" => "string" }
                    ], 
                    "rows" => [
                      {"active" => true, "name" => "rails5", "target_path"=>"~/somepath"},
                      {"active" => false, "name" => "react", "target_path"=>"~/somepath/client"}
                    ]
                  }
                })
            end
          end
        end
      end
    end
  end
end
