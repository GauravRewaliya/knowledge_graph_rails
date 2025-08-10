class SwaggerDynamicController < ApplicationController
  # /view/workspaces/:workspace_id/docs
  def workspace_spec
    workspace_id = params[:workspace_id]
    queries = GraphQueryfier.where(workspace_id: workspace_id)

    spec = {
      openapi: "3.0.1",
      info: {
        title: "Dynamic API for Workspace #{workspace_id}",
        version: "1.0.0"
      },
      paths: {}
    }

    queries.each do |q|
      next unless q.meta_data_of_querifier["url"] && q.meta_data_of_querifier["method"]

      spec[:paths][q.meta_data_of_querifier["url"]] = {
        q.meta_data_of_querifier["method"].downcase.to_sym => {
          summary: q.desc,
          parameters: (q.meta_data_of_querifier["params"] || {}).map do |pname, pdesc|
            {
              name: pname,
              in: "query",
              required: true,
              schema: { type: "string" },
              description: pdesc
            }
          end,
          responses: {
            "200": {
              description: "Successful",
              content: {
                "application/json": {
                  schema: { type: "object" }
                }
              }
            }
          }
        }
      }
    end

    render json: spec
  end
  # /projects/:project_id/graph_db/ .. .. .. ..
  def run_graph_db_swagger_api
    pass
  end
end
