log.kv 'load', 'app_settings' if AppDebug.require?

def app
  @app ||= app_configuration.raw_data_struct
end

def app_print
  log.section_heading 'application settings'
  log.ostruct app
end

# TODO
# def app_configuration
#   KDoc.model :app do
#     settings do
#       name                          :printspeak_domain
#       title                         'Printspeak Domain'
#       description                   'Printspeak domain modal'
#       lib_path                      ''
#       namespaces                    ['']
#       app_path                      '~/dev/printspeak/reference_application/printspeak-domain'
#       git_repo_name                 'printspeak-domain'
#       git_organization              'printspeak'
#       avatar                        'Software Architect'
#       main_story                    'As a Software Architect, I want to build a an enterprise application on a well defined ER model, so I can automate much of my development'
#       author                        'David Cruwys'
#       author_email                  'david@ideasmen.com.au'
#       copyright_date                '2021'
#     end
#   end
# end