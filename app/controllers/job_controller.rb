class JobController < AppController

    get '/jobs' do
        jobs = Job.all
        json_response(data: jobs)
    end
    
    post '/jobs/create' do
        data = JSON.parse(request.body.read)
        begin
            job = Job.create(data)
            json_response(code: 201, data: project)
        rescue => e
            {error: e.message}.to_json
        end
        # json_response(code: 201, data: project)
        # rescue => e
        #     json_response(code: 422, data: { error: e.message })
    end

    delete '/jobs/destroy/:id' do
        begin
            job = Job.find(self.job_id)
            job.destroy
            json_response(data: { message: "project deleted successfully" })
        rescue => e
          json_response(code: 422, data: { error: e.message })
        end
    end

    private

    def job_id
        params['id'].to_i
    end

end