class GraphDbController < ApplicationController
  def run # for swagger doc testing
    gq = GraphQuerifier.find(params[:id])
    params_for_query = params.permit!.to_h.except(:id)
    result = Neo4jDriver.run(gq.cypher_query, params_for_query)
    render json: result
  end

  def run_visual
    query = params[:cypher]
    params_for_query = params[:vars] || {}
    result = Neo4jDriver.run(query, params_for_query)

    nodes = []
    edges = []

    result.each do |record|
      record.values.each do |val|
        if val.respond_to?(:labels) # Node
          nodes << { id: val.element_id, label: val.labels.first, properties: val.properties }
        elsif val.respond_to?(:type) # Relationship
          edges << { from: val.start_node_id, to: val.end_node_id, label: val.type }
        end
      end
    end

    render json: { nodes: nodes.uniq, edges: edges.uniq }
  end
end
