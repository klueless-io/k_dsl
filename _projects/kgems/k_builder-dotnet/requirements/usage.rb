# Examples on how to use for inclusion into USAGE.MD
# ------------------------------------------------------------

KDsl.document :usage do
  def on_action
    # write_json is_edit: true
  end

  table :example_groups do
    fields [:key, :group, :description, f(:featured, false)]

    row :basic_example  , :basic_example          , '', featured: true

    row :sample         , :sample_classes         , ''
  end

  table :examples do
    # status: :done, :current, :backlog:
    # fields [f(:type, :story), f(:status, :todo), :story, :tasks, f(:featured_position, 0)]

    fields [:group_key, :name, :description, :ruby]

    row :basic_example, 'Create solution', <<~TEXT, ruby: <<~RUBY
      Create a new solution that contains many projects to solve a business problem.
    TEXT
      solution = builder.new_solution(:pitstop)
    RUBY

    row :basic_example, 'Create project(s)', <<~TEXT
      Create two projects attached to the solution
      
      ![Build Two Projects](docs/builder-two-projects.png)
    TEXT

    row :sample, 'Create solution', <<~TEXT, ruby: <<~RUBY
      Create a new solution that contains many projects to solve a business problem.
    TEXT
      solution = builder.new_solution(:pitstop)
    RUBY

    row :sample, '', "![](docs/new-solution.png)"
    
    row :sample, 'Create project(s)', <<~TEXT
      Create two projects attached to the solution
      
      ![Build Two Projects](docs/builder-two-projects.png)
    TEXT
    # row :sample, 'Create project(s)', <<~TEXT, ruby: <<~RUBY
    #     Create two projects attached to the solution
    #   TEXT
    #     builder
    #       .current_solution(solution)
    #       .new_project_library(:customer_management_api_dal, 
    #                           name: 'CustomerManagement.Api.Dal',
    #                           variant: :entity_framework)
    #       .new_project_library(:workshop_management_event_handler, 
    #                           name: 'WorkshopManagement.EventHandler.Dal',
    #                           variant: :entity_framework)
    #   RUBY

    row :sample, '', <<~TEXT
      
      <table>
      <tr>
      <td>
      
      ![New Project 1](docs/new-project1.png)
      
      </td>
      <td>
      
      ![New Project 2](docs/new-project2.png)
      
      </td>
      </tr>
      </table>

    TEXT
  end
end
