require 'roar/decorator'
require 'roar/json/hal'

module API
  module V3
    module Kittens
      class KittenRepresenter < ::API::Decorators::Single
        include API::Decorators::LinkedResource
        include ::API::Caching::CachedRepresenter

        cached_representer key_parts: %i(project)

        self_link

        associated_resource :project,
                            as: :definingProject,
                            skip_render: ->(*) { !represented.project.visible?(current_user) }

        link :availableInProjects do
          {
            href: api_v3_paths.projects_by_kitten(represented.id)
          }
        end

        property :id, render_nil: true
        property :name, render_nil: true

#        property :description,
#                 exec_context: :decorator,
#                 getter: ->(*) { 
#                   ::API::Decorators::Formattable.new(represented.description,
#                                                      object: represented,
#                                                      plain: true)
#                 },
#                 render_nil: true
#
#        property :start_date,
#                 exec_context: :decorator,
#                 getter: ->(*) {
#                   datetime_formatter.format_date(represented.start_date, allow_nil: true)
#                 },
#                 render_nil: true
#        property :due_date,
#                 as: 'endDate',
#                 exec_context: :decorator,
#                 getter: ->(*) {
#                   datetime_formatter.format_date(represented.due_date, allow_nil: true)
#                 },
#                 render_nil: true
#        property :status, render_nil: true
#        property :created_on,
#                 as: 'createdAt',
#                 exec_context: :decorator,
#                 getter: ->(*) { datetime_formatter.format_datetime(represented.created_on) }
#        property :updated_on,
#                 as: 'updatedAt',
#                 exec_context: :decorator,
#                 getter: ->(*) { datetime_formatter.format_datetime(represented.updated_on) } 

        def _type
          'Kitten'
        end
      end
    end
  end
end
