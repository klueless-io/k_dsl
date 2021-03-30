DddResourceBuilder.new.init
  .init
  .resource_key('{{full_command}}')
  .language(:csharp)
  .template(:query)
  .generate(:overwrite) # options: :write, :overwrite, :diff 

