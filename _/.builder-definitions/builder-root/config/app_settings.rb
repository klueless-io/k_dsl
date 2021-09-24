log.kv 'load', 'app_settings' if AppDebug.require?

def app
  @app ||= app_configuration.raw_data_struct
end

def app_print
  log.section_heading 'application settings'
  log.ostruct app
end

def app_configuration
  KDoc.model :app do
    s = settings do
      name                          :printspeak
      title                         'Printspeak'
      description                   'Printspeak enterprise reference application'
      lib_path                      ''
      namespaces                    ['']
      app_path                      '~/dev/printspeak/reference_application'
      git_repo_name                 'printspeak-react'
      git_organization              'printspeak'
      avatar                        'Franchisee'
      main_story                    'As a Print franchisee, I want to market my business effectively, so that my business is profitable'
      author                        'David Cruwys'
      author_email                  'david@ideasmen.com.au'
      copyright_date                '2021'
    end

    table :projects do
      # fields :column1, :column2, f(:column3, false), f(:column4, default: 'CUSTOM VALUE')

      fields :name,
            :type,
            :description,
            f(:lib_path, default: s.lib_path),
            f(:namespaces, default: s.namespaces),
            f(:app_path, default: s.app_path),
            f(:git_organization, default: s.git_organization),
            f(:avatar, default: s.avatar),
            f(:main_story, default: s.main_story),
            f(:author, default: s.author),
            f(:author_email, default: s.author_email),
            f(:copyright_date, default: s.copyright_date)

      row :printspeak             , :root_folder        , "#{s.title} enterprise reference application"

      row :printspeak_domain      , :domain_modal       , "#{s.title} domain modal",
          git_repo_name:            'printspeak-domain',
          app_path:                 File.join(s.app_path, 'printspeak-domain'),
          notes:                    'Domain is a tool that converts the schema.rb into a rich schema by reading in the code and annotating the schema with extra information that is found in the code.',
          new_project_command:      'k_builder-watch -n .'

      row :printspeakx            , :rails              , "#{s.title} rails 6 application",
          git_repo_name:            'printspeakx',
          ruby_version:             '2.6.6',
          rails_version:            '6.1.3',
          rails_full_version:       '6.1.3.2',
          database_name:            'printspeakx',
          database_password:        'SamplePassword',
          app_path:                 File.join(s.app_path, 'printspeakx'),
          new_project_command:      'rails new . -T -d postgresql --force --webpack=react --skip-git --skip-action-mailer --skip-action-mailbox --skip-action-text'

      row :printspeak_react       , :react              , "#{s.title} admin UI in REACT",
          git_repo_name:            'printspeak-react',
          app_path:                 File.join(s.app_path, 'printspeak-react'),
          new_project_command:      'npx create-react-app .'

      row :printspeak_react_native, :react_native       , "#{s.title} admin UI for mobile in REACT Native",
          git_repo_name:            'printspeak-react-native',
          app_path:                 File.join(s.app_path, 'printspeak-react-native'),
          new_project_command:      'npx expo init . -t expo-template-blank-typescript'
    end
  end
end