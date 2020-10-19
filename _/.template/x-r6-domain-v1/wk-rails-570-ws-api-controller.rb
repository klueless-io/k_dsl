module Api
  module V1

    # Restful Actions against {{camelU settings.Model}}
    class {{camelU settings.Models}}Controller < ApiController
      respond_to :json

      # ======================================================================
      # CRUD Actions     - Create, Read (show/query/multi), Update & Delete
      # ======================================================================

      # Show a list of sample endpoints for the {{camelU settings.Models}} API
      def sample
        super('{{camelL settings.Model}}', build_sample_endpoints('{{camelL settings.Model}}', main_key: '{{snake settings.MainKey}}'))
      end

      # Index - List of {{camelU settings.Models}} query with configurable sort and filter options
      #
      # Result (JSON) Nodes:
      #     result            : Success or Failure result
      #       success         : true or false
      #       message         : (optional) human message indicating success or failure
      #       errors          : (optional) Array of errors message when status == false
      #
      #     page              : Pagination settings for this request
      #     rows              : List of {{camelU settings.Models}}
      #
      #
      # Samples:
      #     Success (HTTP Status 200)
      #     http://localhost:{{settings.RailsPort}}/api/v1/{{snake settings.Models}}
      #
      #     Failure (HTTP Status 404)
      #     http://localhost:{{settings.RailsPort}}/api/v1/{{snake settings.Models}}
      #     http://localhost:{{settings.RailsPort}}/api/v1/{{snake settings.Models}}?options={"page":{"active":true,"no":1,"size":50},"filter":{"search":""},"sort":[{"field":"name","sort":"asc"}]}
      def index
        # L.block '{{camelU settings.Models}} Index'
        # L.info params[:options]

        query = Query::{{camelU settings.Model}}Query.new(params[:options])

        rows = query.run
        page = query.get_current_page

        # How do we handle errors?, e.g. is there a 404
        render_success_query(rows, page)
      end

      # Show - Get {{camelU settings.Model}} by ID as JSON
      #
      # Result (JSON) Nodes:
      #     result            : Success or Failure result
      #       success         : true or false
      #       message         : (optional) human message indicating success or failure
      #       errors          : (optional) Array of errors message when status == false
      #
      #     row               : Single {{camelU settings.Model}}
      #
      # Samples:
      #     Success (HTTP Status 200)
      #     http://localhost:{{settings.RailsPort}}:3001/api/v1/{{snake settings.Models}}/1
      #
      #     Failure (HTTP Status 404)
      #     http://localhost:{{settings.RailsPort}}/api/v1/{{snake settings.Models}}/10000069
      #     http://localhost:{{settings.RailsPort}}/api/v1/{{snake settings.Models}}/david
      def show
        # L.block '{{camelU settings.Models}} Show'

        row = {{camelU settings.Model}}.find_by(id: params[:id])

        if row.present?
          return render_success_row(row)
        end

        return render_error('Could not find {{titleize (humanize settings.Model)}}')
      end

      # Multi - Select multiple {{camelU settings.Models}} for bulk actions
      #
      # Result (JSON) Nodes:
      #     result            : Success or Failure result
      #       success         : true or false
      #       message         : (optional) human message indicating success or failure
      #       errors          : (optional) Array of errors message when status == false
      #
      #     rows              : List of {{camelU settings.Models}}
      #
      # Samples:
      #     http://localhost:{{settings.RailsPort}}/api/v1/{{snake settings.Models}}/multi?ids=1,2
      def multi
        L.block '{{camelU settings.Models}} Multi Select'

        ids = params[:ids] ? params[:ids].split(',') : []

        rows = {{camelU settings.Model}}.where(id: ids)

        return render_success_rows(rows)
      end

      # Create {{camelU settings.Model}}
      #
      # Samples:
      #     (POST) http://localhost:{{settings.RailsPort}}/api/v1/{{snake settings.Models}}
      def create
        # L.block '{{camelU settings.Model}} - Create'

        row = {{camelU settings.Model}}.new(create_{{snake settings.Model}}_params)

        if row.save
          return render_success_row(row, '{{titleize (humanize settings.Model)}} Created')
        end

        return render_error('Failed to create {{titleize (humanize settings.Model)}}', row.errors.full_messages)

      end

      # Update {{camelU settings.Model}}
      #
      # Samples:
      #     (PUT) http://localhost:{{settings.RailsPort}}/api/v1/{{snake settings.Models}}/:id
      #
      # Result (JSON) Nodes:
      #     result            : Success or Failure result
      #       success         : true or false
      #       message         : (optional) human message indicating success or failure
      #       errors          : (optional) Array of errors message when status == false
      #
      #     row               : Single {{camelU settings.Model}}
      #
      # Samples:
      #     Success (HTTP Status 200)
      #     http://localhost:{{settings.RailsPort}}/api/v1/{{snake settings.Models}}/1
      def update
        # L.block '{{camelU settings.Model}} - Update'

        row = {{camelU settings.Model}}.find_by(id: params[:id])

        if row.present?
          if row.update(update_{{snake settings.Model}}_params)
            return render_success_row(row, '{{titleize (humanize settings.Model)}} Updated')
          end
          
          return render_error('Failed to update {{titleize (humanize settings.Model)}}', row.errors.full_messages)
        end

        return render_error('Could not find {{titleize (humanize settings.Model)}}')

      end

      # Delete {{camelU settings.Model}}
      #
      # Samples:
      #     (DELETE) http://localhost:{{settings.RailsPort}}/api/v1/{{snake settings.Models}}/id
      def destroy
        # L.block '{{camelU settings.Model}} - Destroy'

        row = {{camelU settings.Model}}.find_by(id: params[:id])

        if row.present?
          if row.destroy
            return render_success_destroy(row, '{{titleize (humanize settings.Model)}} Deleted')
          end

          return render_error('Failed to delete {{titleize (humanize settings.Model)}}', row.errors.full_messages)
        end

        return render_error('Could not find {{titleize (humanize settings.Model)}}')

      end

      # ======================================================================
      # Custom Actions
      # ======================================================================

      # ----------------------------------------------------------------------
      private
      # ----------------------------------------------------------------------

      # Strong params for updating {{camelU settings.Model}}
      def update_{{snake settings.Model}}_params
        # http://blog.trackets.com/2013/08/17/strong-parameters-by-example.html

        # Only Change this if you want to have different params for create and update
        create_{{snake settings.Model}}_params
      end

      # Strong params for creating {{camelU settings.Model}}
      def create_{{snake settings.Model}}_params
        params.require(:{{snake settings.Model}}).permit({{#each relations}}{{#ifx this.type '==' 'OneToOne'}}:{{snake this.field}},{{/ifx}}{{/each}}{{#each rows_and_virtual}}
          :{{snake this.name}}{{#ifx this.db_type '==' 'jsonb'}}, {{snake this.name}}: {}{{/ifx}}{{#if @last}}{{else}}, {{/if}}{{/each}})
      end

    end
  end
end
