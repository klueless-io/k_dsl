KDsl.microapp :ruby_docs do
  s = settings do
    description             'Make existing code look like a template'
    story                   'As a developer, I should be able to convert code into a template with curly braces, so that I can add existing code patterns into the Klueless Generator .template folder quickly'

    code_folder             'somepath/code'
    template_folder         'somepath/template'
  end

  # Configure a table with input (:code_name) and output (:template_name) files
  # And for each row, process it via the GPT3 training algorithm
  table do
    fields [:code_name, :template_name]

    row 'file1.rb', 'file1.rb'
  end

  # Alternative technique would be just to process the files in
  # :code_folder / :template_folder and match them by same name

end
