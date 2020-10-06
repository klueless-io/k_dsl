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
  let(:ruby_file) { File.join(gem_root, 'spec/factories/dsls/ruby_files/ruby1.rb') }
  let(:ruby_one_dsl_file) { File.join(gem_root, 'spec/factories/dsls/simple_dsl/one_dsl.rb') }
  let(:ruby_two_dsl_file) { File.join(gem_root, 'spec/factories/dsls/simple_dsl/two_dsl.rb') }

  describe '#constructor' do
    it 'is linked to a project' do
      expect(subject.project).not_to be_nil
    end

    it 'does not start with an artifact' do
      expect(subject.artifact).to be_nil
    end

    context 'when file provided' do
      context 'with any old file' do
        it do
          is_expected.to have_attributes(
          file: file,
          type: described_class::TYPE_UNKNOWN,
          source: described_class::SOURCE_FILE,
          documents: [])
        end
      end

      context 'with ruby file' do
        let(:file) { ruby_file }
  
        it { is_expected.to have_attributes(file: file, type: described_class::TYPE_RUBY) }
  
        context 'with Klueless ruby DSL' do
          let(:file) { ruby_one_dsl_file }

          it { is_expected.to have_attributes(file: file, type: described_class::TYPE_RUBY) }
        end
      end
  
      context 'with json file' do
        let(:file) { '/somepath/file.json' }
  
        it { is_expected.to have_attributes(file: file, type: described_class::TYPE_JSON) }
      end
  
      context 'with csv file' do
        let(:file) { '/somepath/file.csv' }
        
        it { is_expected.to have_attributes(file: file, type: described_class::TYPE_CSV) }
      end
    end
  end
  
  describe '#load' do
    before do
      resource.load_content
      resource.register
      resource.load
    end

    context 'csv' do
      let(:file) { csv_file }

      context '.documents' do
        subject { resource.documents }

        it { is_expected.not_to be_empty }
      end
    end

    context 'json' do
      let(:file) { json_file }

      context '.documents' do
        subject { resource.documents }
  
        it { is_expected.not_to be_empty }
        it { expect(subject.length).to eq 1 }
      end
    end

    context 'ruby' do
      let(:file) { ruby_file }

      context '.documents' do
        subject { resource.documents }
  
        it { is_expected.not_to be_empty }
        it { expect(subject.length).to eq 1 }
      end
    end

    context 'ruby_one_dsl' do
      let(:file) { ruby_one_dsl_file }

      context '.documents' do
        subject { resource.documents }
  
        it { is_expected.not_to be_empty }
        it { expect(subject.length).to eq 1 }
      end
    end

    context 'ruby_two_dsl' do
      let(:file) { ruby_two_dsl_file }

      context '.documents' do
        subject { resource.documents }
  
        it { is_expected.not_to be_empty }
        it { expect(subject.length).to eq 2 }
      end
    end
  end
end
