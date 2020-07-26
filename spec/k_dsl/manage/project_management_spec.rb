# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Manage::ProjectManagement do
  let(:manager) { described_class.new }

  describe '#manage' do
    subject { manager }

    context 'has instance' do
      it { is_expected.not_to be_nil }
    end
  end

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
      let(:project) { KDsl::Manage::Project.new }

      it 'active_project is set' do
        subject
        expect(manager.active_project).to eq(project)
      end

      it 'projects are updated' do
        expect(manager.projects).not_to include(project)
        subject
        expect(manager.projects).to include(project)
      end

      context 'when active_project is called multiple times with same project' do
        it 'projects only update once' do
          expect(manager.projects.length).to eq 0
          manager.activate_project(project)
          expect(manager.projects.length).to eq 1
          manager.activate_project(project)
          expect(manager.projects.length).to eq 1
        end
      end

      context 'when active_project is called multiple times with different projects' do
        let(:project2) { KDsl::Manage::Project.new }
        it 'projects only update once' do
          expect(manager.projects.length).to eq 0
          manager.activate_project(project)
          expect(manager.projects.length).to eq 1
          manager.activate_project(project2)
          expect(manager.projects.length).to eq 2
        end
      end
    end
  end

  describe '#register_with_project' do
    subject { manager.register_with_project(document) }

    let(:document) { KDsl::Model::Document.new :xmen }

    context 'when there is no active project' do
      it { expect(subject).to eq(:no_project) }
    end

    context 'when there is an active project' do
      let(:project) { KDsl::Manage::Project.new }

      before { manager.activate_project(project) }
      after { manager.deactivate_project(project) }

      it { expect(subject).to eq(:no_project) }
      context 'when there is no active project' do
      end
    end
  end
end
