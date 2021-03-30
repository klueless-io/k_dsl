DddResourceBuilder.new
  .init
  .resource_key('{{full_command}}')
  .language(:csharp)
  .template(:action)
  .generate(:overwrite) # options: :write, :overwrite, :diff 
