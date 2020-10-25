KDsl.document :run_command1 do
  settings do
    description "This command will create a folder under .output called basic_app and then write hello.txt into that folder"
  end

  def on_action
    run_command 'mkdir basic_app && cd basic_app && echo "hello world1" > hello.txt', command_creates_top_folder: true
  end
end

KDsl.document :run_command2 do
  settings do
    description "This command will write hello.txt into a folder that is precreated: .output/basic_app"
  end

  def on_action
    run_command 'echo "hello world2" > hello.txt'
  end
end
