DddResourceBuilder.new.init
  .init
  .resource_key('{{full_command}}')
  .language(:csharp)
  .template(:service)
  .generate(:overwrite) # options: :write, :overwrite, :diff 

