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
  let(:file3) { File.join(gem_root, 'spec/factories/dsls/ruby_files/ruby3.rb') }

  let(:dsl_file1) { File.join(gem_root, 'spec/factories/dsls/simple_dsl/one_dsl.rb') }
  let(:dsl_file2) { File.join(gem_root, 'spec/factories/dsls/simple_dsl/two_dsl.rb') }

  context 'when using a simple ruby file' do
    let(:file) { file1 }

    before { resource.load_content }

    it { is_expected.to have_attributes(file: file, type: described_class::TYPE_RUBY) }
    
    context 'before register' do
      it { expect { Ruby1.new }.to raise_error NameError }

      describe 'project.resource_documents' do
        subject { project.resource_documents }

        it { is_expected.to be_empty }
      end      

      context '#register' do
        before { resource.register }

        it { expect(Ruby1.new).not_to be_nil }
        it { expect(Ruby1.new.some_prop).to eq('Value') }
        it { is_expected.to have_attributes(file: file, type: described_class::TYPE_RUBY) }

        describe 'project.resource_documents' do
          subject { project.resource_documents }

          it { is_expected.not_to be_empty }

          it 'has one document' do
            expect(subject.length).to eq 1
            expect(subject.first.data).to eq({})
          end

          it 'has key' do
            expect(subject.first.key).to eq('ruby1')
          end

          it 'has type' do
            expect(subject.first.type).to eq('ruby')
          end

          context '#load' do
            before { resource.load }
      
            it 'has one document with data' do
              expect(subject.first.data).to eq({})
            end
          end
        end      
      end
    end
  end

  context 'when using ruby file with syntex error' do
    let(:file) { file3 }

    before { resource.load_content }

    it { is_expected.to have_attributes(file: file, type: described_class::TYPE_RUBY) }
    
    context 'before register' do
      describe 'project.resource_documents' do
        subject { project.resource_documents }

        it { is_expected.to be_empty }
      end      

      context '#register' do
        before { resource.register }

        describe 'project.resource_documents' do
          subject { project.resource_documents }

          it 'has one document' do
            expect(subject.length).to eq 1
            expect(subject.first.data).to eq({})
            # subject.first.document.debug(true)
          end

          it 'has key' do
            expect(subject.first.key).to eq('ruby3')
          end

          it 'has type' do
            expect(subject.first.type).to eq('ruby')
          end

          context '#load' do
            before { resource.load }
      
            it 'has one document with data' do
              expect(subject.first.data).to eq({})
            end
          end
        end
 
      end
    end
  end

  context 'when using ruby file with one DSL' do
    let(:file) { dsl_file1 }

    before { resource.load_content }

    it { is_expected.to have_attributes(file: file, type: described_class::TYPE_RUBY) }
    
    context '#register' do
      before { resource.register }

      it { is_expected.to have_attributes(file: file, type: described_class::TYPE_RUBY_DSL) }

      describe 'project.resource_documents' do
        subject { project.resource_documents }

        it { is_expected.not_to be_empty }

        it 'has one document' do
          expect(subject.length).to eq 1
        end
      end

      describe 'resource.documents' do
        subject { resource.documents }

        it { is_expected.not_to be_empty }

        it 'has one document' do
          expect(subject.length).to eq 1
        end

        context 'document[0]' do
          subject { resource.documents[0] }

          it 'has unique_key' do
            expect(subject.unique_key).to eq('my_name_entity')
          end
        end
      end

        # xcontext '#load' do
        #   before { resource.load }
    
        #   it 'has one document with data' do
        #     expect(subject.first.data).to eq({})
        #   end
        # end
    end
  end

  context 'when using ruby file with two DSLs' do
    let(:file) { dsl_file2 }

    before { resource.load_content }

    it { is_expected.to have_attributes(file: file, type: described_class::TYPE_RUBY) }
    
    context '#register' do
      before { resource.register }

      it { is_expected.to have_attributes(file: file, type: described_class::TYPE_RUBY_DSL) }

      describe 'project.resource_documents' do
        subject { project.resource_documents }

        it { is_expected.not_to be_empty }

        it 'has one document' do
          expect(subject.length).to eq 2
          expect(subject.first.data).to eq({})
        end

        it 'has unique_key' do
          expect(subject.first.unique_key).to eq('my_name1_entity')
        end

        xcontext '#load' do
          before { resource.load }
    
          it 'has one document with data' do
            expect(subject.first.data).to eq({})
          end
        end
      end      
    end
  end
end
