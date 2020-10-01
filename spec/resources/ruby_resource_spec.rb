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
end
