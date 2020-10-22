# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Extensions::Writable do

  context 'fake document' do
    class FakeDocument; attr_accessor :resource; end

    context 'extension not loaded' do
      subject { document }

      let(:document) { FakeDocument.new }

      it { is_expected.not_to respond_to(:write_as) }

      context 'after extension loaded' do
        before { FakeDocument.include(KDsl::Extensions::Writable) }

        it { is_expected.to respond_to(:write_as) }

        describe '#write_as' do
          subject { document.write_as nil, nil }
    
          context 'when document not linked to a project' do
            it 'will print a warning log message' do
              expect(document).to receive(:warn).with('Write As Skipped: Document not linked to a project')
              subject
            end
          end
        end
      end
    end
  end

  context 'real document' do
    let(:project) { KDsl::Manage::Project.new('app_name', config) }
    let(:config) do
      KDsl::Manage::ProjectConfig.new do
        base_resource_path = File.join(Dir.getwd, 'spec', 'factories', 'dsls')
      end
    end
    let(:resource) { KDsl::Resources::Resource.instance(project: project, file: 'somedata.txt') }

    context 'write document to output file' do
      let(:document) { KDsl::Model::Document.new('key', &block) }
      let(:data) { document.data }
    
      let(:some_file) { Tempfile.new() }
      let(:json_file) { Tempfile.new(['','.json']) }
      let(:yaml_file) { Tempfile.new(['','.yaml']) }
      let(:html_file) { Tempfile.new(['','.html']) }
      
      before do
        document.execute_block
        resource.add_document(document)
      end

      after do
        some_file.unlink
        json_file.unlink
        yaml_file.unlink
        html_file.unlink
      end

      let(:block) do
        lambda do |_|
        end
      end

      describe '#write_as' do
        context 'error handling' do
          context 'when extension is unknown' do
            subject { document.write_as(data, some_file.path) }
    
            it { expect { subject }.to raise_error 'Provide a valid extension or as_type. Supported types: [json, yaml]' }
          end
    
          context 'when extension is known, but overridden as_type is unknown' do
            subject { document.write_as(data, json_file.path, as_type: :abc) }
    
            it { expect { subject }.to raise_error 'Provide a valid extension or as_type. Supported types: [json, yaml]' }
          end
        end

        context 'when extension is unknown' do
          context 'and as_type: :json' do
            subject { document.write_as(data, some_file.path, as_type: :json) }
            
            it 'input should match output' do
              subject
              expect(File.exist?(some_file.path)).to be_truthy
              output = JSON.parse File.read(some_file.path)
              expect(document.data).to eq(output)
            end
          end

          context 'and as_type: :yaml' do
            subject { document.write_as(data, some_file.path, as_type: :yaml) }
            
            it 'input should match output' do
              subject
              expect(File.exist?(some_file.path)).to be_truthy
              output = YAML.load File.read(some_file.path)
              expect(document.data).to eq(output)
            end
          end

          context 'and as_type: :html' do
            subject { document.write_as(data, some_file.path, as_type: :html) }
            
            it 'input should match output' do
              subject
              expect(File.exist?(some_file.path)).to be_truthy
              output = File.read(some_file.path)
              expect(output).to start_with('<html></html>')
            end
          end
        end

        context 'when output file is' do
          context '.json' do
            subject { document.write_as(data, json_file.path) }
            
            it 'write data as json' do
              subject
              expect(File.exist?(json_file.path)).to be_truthy
              output = JSON.parse File.read(json_file.path)
              expect(document.data).to eq(output)
            end
          end

          context '.yaml' do
            subject { document.write_as(data, yaml_file.path) }
            
            it 'write data as yaml' do
              subject
              expect(File.exist?(yaml_file.path)).to be_truthy
              output =YAML.load File.read(yaml_file.path)
              expect(document.data).to eq(output)
            end
          end

          context '.html' do
            subject { document.write_as(data, html_file.path, template: '<html>custom</html>') }
            
            it 'write data as html' do
              subject
              expect(File.exist?(html_file.path)).to be_truthy
              output = File.read(html_file.path)
              expect(output).to start_with('<html>custom</html>')
            end
          end
        end
      end

      context '#write_**** helpers' do
        let(:block) do
          lambda do |_|
            settings do
              rails_port        3000
              model             'User'
              active            true
            end

            rows :custom_rows do

              fields [:column1, :column2, f(:column3, false)]

              row column1: 'david'  
              row 'david','cruwys', column3: true

            end
          end
        end

        describe '#write_json' do
          context 'using .raw_data via with_meta: false' do
            subject { document.write_json } #  is_edit: true

            it 'input should match output' do
              file = subject
              expect(File.exist?(file)).to be_truthy
              output = JSON.parse File.read(file)
              expect(document.raw_data).to eq(output)
              expect(file).to end_with('key_entity.json')
            end
          end

          context 'using .data via with_meta: true' do
            subject { document.write_json with_meta: true }

            it 'input should match output' do
              file = subject
              expect(File.exist?(file)).to be_truthy
              output = JSON.parse File.read(file)
              expect(document.data).to eq(output)
              expect(file).to end_with('key_entity.meta.json')
            end
          end
        end
  
        describe '#write_yaml' do
          context 'using .raw_data via with_meta: false' do
            subject { document.write_yaml }

            it 'input should match output' do
              file = subject
              expect(File.exist?(file)).to be_truthy
              output = YAML.load File.read(file)
              expect(document.raw_data).to eq(output)
              expect(file).to end_with('key_entity.yaml')
            end
          end

          context 'using .data via with_meta: true' do
            subject { document.write_yaml with_meta: true }

            it 'input should match output' do
              file = subject
              expect(File.exist?(file)).to be_truthy
              output = YAML.load File.read(file)
              expect(document.data).to eq(output)
              expect(file).to end_with('key_entity.meta.yaml')
            end
          end
        end

        describe '#write_html' do
          context 'using .raw_data via with_meta: false' do
            subject { document.write_html(template: '<html>model: {{settings.model}}</html>') }

            it 'input should match output' do
              file = subject
              expect(File.exist?(file)).to be_truthy
              output = File.read(file)
              expect(output).to start_with('<html>model: User</html>')
              expect(file).to end_with('key_entity.html')
            end
          end
        end
      end
    end
  end

end
