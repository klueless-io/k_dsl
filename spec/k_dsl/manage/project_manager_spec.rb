# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Manage::ProjectManager do
  let(:manager) { described_class.new }
  let(:project_name) { 'app_name' }

  describe '.projects' do
    subject { manager.projects }

    it { is_expected.to be_empty }
  end

  describe '.active_project' do
    subject { manager.active_project }

    it { is_expected.to be_nil }
  end

  describe '#activate_project' do
    subject { manager.activate_project(project) }

    context 'when project not supplied' do
      let(:project) { nil }

      it { expect { subject }.to raise_error KDsl::Error }
    end

    context 'when project supplied' do
      let(:project) { KDsl::Manage::Project.new(project_name) }

      it 'active_project is set' do
        subject
        expect(manager.active_project).to eq(project)
      end

      it 'projects are updated' do
        expect(manager.projects).not_to include(project)
        subject
        expect(manager.projects).to include(project)
      end
    end
  end

  describe '#add_project' do
    subject { manager.add_project(project) }

    context 'when project not supplied' do
      let(:project) { nil }

      it { expect { subject }.to raise_error KDsl::Error }
    end

    context 'when invalid project is supplied' do
      let(:project) { 'not a project class' }

      it { expect { subject }.to raise_error KDsl::Error }
    end

    context 'when project supplied' do
      let(:project) { KDsl::Manage::Project.new(project_name) }

      it 'projects are added' do
        expect(manager.projects).not_to include(project)
        subject
        expect(manager.projects).to include(project)
      end

      it 'project becomes managed?' do
        expect(project.managed?).to be_falsy
        subject
        expect(project.managed?).to be_truthy
      end

      context 'when add_project is called multiple times with same project' do
        it 'projects only update once' do
          expect(manager.projects.length).to eq 0
          manager.add_project(project)
          expect(manager.projects.length).to eq 1
          manager.add_project(project)
          expect(manager.projects.length).to eq 1
        end
      end

      context 'when add_project is called multiple times with different projects' do
        let(:project2) { KDsl::Manage::Project.new(project_name) }
        it 'projects only update once' do
          expect(manager.projects.length).to eq 0
          manager.add_project(project)
          expect(manager.projects.length).to eq 1
          manager.add_project(project2)
          expect(manager.projects.length).to eq 2
        end
      end
    end
  end
  
  # describe '#register_with_project' do
  #   subject { manager.register_with_project(document) }

  #   let(:document) { KDsl::Model::Document.new :xmen }

  #   context 'when there is no active project' do
  #     it { expect(subject).to eq(:no_project) }
  #   end

  #   context 'when there is an active project' do
  #     let(:project) { KDsl::Manage::Project.new(project_name) }

  #     before { manager.activate_project(project) }
  #     after { manager.deactivate_project(project) }

  #     it { expect(subject).to eq(:no_project) }
  #     context 'when there is no active project' do
  #     end
  #   end
  # end
end
