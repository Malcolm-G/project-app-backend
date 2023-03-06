class ProjectController < AppController

    set :views, './app/views'

    # @method: Display a small welcome message
    get '/hello' do
        "Our very first controller"
    end

        # @method: Display all projects
        get '/projects' do
            projects = Project.all
            json_response(data: projects)
        end

        get '/projects/:userid' do
            user_id = params['userid'].to_i
            my_projects = User.find(user_id).own_projects
            projects_part_of = User.find(user_id).projects
            # user_projects={my_projects:my_projects,projects_part_of:projects_part_of}
            user_projects = {my_projects:my_projects, part_of:projects_part_of}
            user_projects.to_json
        end

        get '/project/:id/members' do
            project_id = params['id'].to_i
            members = Project.find(project_id).users
            member_info = members.map do |member|
                {id: member.id,name:member.name,username:member.username}
            end
            member_info.to_json
        end
    
        # @view: Renders an erb file which shows all PROJECTS
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

    # @method: Update existing TO-DO according to :id
    put '/projects/update/:id' do
        begin
            project = Project.find(self.project_id)
            project.update(self.data)
            # project.to_json

            json_response(data: { message: "project updated successfully" })
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