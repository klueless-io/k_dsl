# ----------------------------------------------------------------------
# {{camelU settings.Model}} Model
#
# Note: file is generated so add/comment out the code as needed
#       Here is a nice summary of associations and validations that 
#       could be of use with this model
#       https://gist.github.com/rstacruz/1569572
# ----------------------------------------------------------------------
class {{camelU settings.Model}} < ApplicationRecord

  # https://blog.bigbinary.com/2016/06/21/rails-5-supports-adding-comments-migrations.html

  {{#ifx settings.ModelType '==' 'AdminUser'}}
  # ----------------------------------------------------------------------
  # Devise configuration (+ optional configs)  
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # ----------------------------------------------------------------------
  devise :database_authenticatable, :recoverable, :rememberable, :validatable
  {{/ifx}}
  {{#ifx settings.ModelType '==' 'BasicUser'}}
  # ----------------------------------------------------------------------
  # Devise configuration (+ optional configs)  
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # ----------------------------------------------------------------------
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  {{/ifx}}

  # ----------------------------------------------------------------------
  # Relationships
  # ----------------------------------------------------------------------

{{#each relations_one_to_one}}
  belongs_to :{{snake this.name}}{{#ifx this.json.optional '==' true}}, optional: true{{/ifx}}
{{/each}}
{{#each relations_has_one}}
  has_one :{{snake this.name}}{{#ifx this.json.optional '==' true}}, optional: true{{/ifx}}
{{/each}}
{{#each relations_one_to_many}}
  has_many :{{snake this.name_plural}}
{{/each}}
{{#if relations_many_to_many}}

  # Many to Many
{{#each relations_many_to_many}}
  has_many :{{this.through}}
  has_many :{{this.name_plural}}, through: :{{this.through}}

{{/each}}
{{/if}}

  # ----------------------------------------------------------------------
  # Validations
  # ----------------------------------------------------------------------

  {{#each rows}}
  {{#ifx ../settings.ModelType '==' 'AdminUser'}}
  {{else ifx ../../settings.ModelType '==' 'BasicUser'}}
  {{else ifx this.type '==' 'Boolean'}}
  validates :{{snake this.name}}, inclusion: { in: [true, false], message: "%{value}must be provided", allow_nil: false }
  {{else ifx this.type '==' 'PrimaryKey'}}
  {{else ifx this.type '==' 'ForeignKey'}}
  {{else ifx this.db_type '==' 'jsonb'}}
  validates :{{snake this.name}}, presence: true, json_hash: true
  {{else}}
  validates :{{snake this.name}}, presence: true
{{/ifx}}
  {{/each}}

  # ----------------------------------------------------------------------
  # Accessors XYZ
  # ----------------------------------------------------------------------

  {{#ifx settings.ModelType '==' 'AdminUser'}}
  def display_name
    return self.email
  end
  {{/ifx}}
  {{#ifx settings.ModelType '==' 'BasicUser'}}
  def display_name
    return self.email
  end
  {{/ifx}}

  # Can be useful in active admin
  # def name
  #   return self.name
  # end

end
