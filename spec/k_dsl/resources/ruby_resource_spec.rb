# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Resources::RubyResource do
  subject { resource }

  let(:resource) do
    KDsl::Resources::Resource.instance(
      project: project,
      file: file
  )
  end

  let(:project) { KDsl::Manage::Project.new('sample') }
  let(:gem_root) { Gem::Specification.find_by_name("k_dsl").gem_dir }

  let(:file1) { File.join(gem_root, 'spec/factories/dsls/ruby_files/ruby1.rb') }
  let(:file2) { File.join(gem_root, 'spec/factories/dsls/ruby_files/ruby2.rb') }
  let(:file3) { File.join(gem_root, 'spec/factories/dsls/ruby_files/ruby3.rb') }
  let(:file4) { File.join(gem_root, 'spec/factories/dsls/ruby_files/ruby4.rb') }
  let(:file) { file1 }

  describe '#instance' do
    it { is_expected.to have_attributes(file: file, type: described_class::TYPE_RUBY) }
  end

  describe '#load - ruby code' do
    context 'before load' do
      it { expect { Ruby1.new }.to raise_error NameError }
    end

    context 'after load' do
      let(:file) { file2 }

      before { resource.load }
      it { expect(Ruby2.new).not_to be_nil }
      it { expect(Ruby2.new.some_prop).to eq('Other Value') }
    end

    context 'invalid ruby code' do
      subject { resource.error }
      let(:file) { file3 }

      before { resource.load }

      it { expect(subject).to be_a(NameError) }
      it { expect(subject.message).to eq("undefined local variable or method `bad_ruby_method' for Ruby3:Class") }
    end
  end

  describe '.documents' do
    subject { resource.documents }

    it { is_expected.to be_empty }

    context '#load' do
      let(:file) { file4 }

      before { resource.load }

      it { is_expected.not_to be_nil }

      it 'has key' do
        expect(subject.first.key).to eq('ruby4')
      end

      it 'has type' do
        expect(subject.first.type).to eq('ruby')
      end
    end
  end
end
