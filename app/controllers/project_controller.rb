class ProjectController < AppController

    set :views, './app/views'

    # @method: Display a small welcome message
    get '/hello' do
        "Our very first controller"
    end

    # @method: Add a new project to the DB
    post '/projects/create' do
        data = JSON.parse(request.body.read)
        begin
            project = Project.create(data)
            json_response(code: 201, data: project)
        rescue => e
            {error: e.message}.to_json
        end
        # json_response(code: 201, data: project)
        # rescue => e
        #     json_response(code: 422, data: { error: e.message })
    end

    # @method: Display all todos
    get '/projects' do
        projects = Project.all
        json_response(data: projects)
    end

    # @view: Renders an erb file which shows all TODOs
    # erb has content_type because we want to override the default set above
    get '/' do
        @projects = Project.all.map { |project|
          {
            project: project,
            badge: project_status_badge(project.status)
          }
        }
        @i = 1
        erb_response :projects
    end

    # @method: Update existing TO-DO according to :id
    put '/projects/update/:id' do
        begin
            project = Project.find(self.project_id)
            project.update(self.data)
            # project.to_json

            json_response(data: { message: "todo updated successfully" })
        rescue => e
            json_response(code: 422 ,data: { error: e.message })
        end
    end

    # @method: Delete TO-DO based on :id
    delete '/projects/destroy/:id' do
        begin
            project = Project.find(self.project_id)
            project.destroy
            json_response(data: { message: "project deleted successfully" })
        rescue => e
          json_response(code: 422, data: { error: e.message })
        end
    end


    private

    # @helper: format body data
    def data(create: false)
        payload = JSON.parse(request.body.read)
        # if create
        #     payload["createdAt"] = Time.now
        # end
        payload
    end

    # @helper: retrieve to-do :id
    def project_id
        params['id'].to_i
    end

    # @helper: format status style
    def project_status_badge(status)
        case status
            when 'CREATED'
                'bg-info'
            when 'ONGOING'
                'bg-success'
            when 'CANCELLED'
                'bg-primary'
            when 'COMPLETED'
                'bg-warning'
            else
                'bg-dark'
        end
    end


end