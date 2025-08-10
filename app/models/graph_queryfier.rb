# == Schema Information
#
# Table name: graph_queryfiers
#
#  id                     :integer          not null, primary key
#  entity_type            :string
#  desc                   :string
#  cypher_dynamic_query   :string
#  meta_data_swagger_docs :json => {method: GET , params: .. , url: .. , requried_params: .. , examples: [], is_depricated: False}
#  workspace_id           :integer          not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_graph_queryfiers_on_workspace_id  (workspace_id)
#

class GraphQueryfier < ApplicationRecord
  belongs_to :workspace

  def self.get_entites(workspace_id = nil)
    where(workspace_id: workspace_id, entity_type: "entities") if workspace_id
    where(entity_type: "entities")
  end

  def self.get_relations(workspace_id = nil)
    where(workspace_id: workspace_id, entity_type: "relations") if workspace_id
    where(entity_type: "relations")
  end

  def self.get_cypher_docs
    GraphQueryfier.all
  end

  def execute
    Neo4jDriver.session.run(cypher_dynamic_query)
  end

  def self.seed_data
    [
      # Question queries
      {
        entity_type: "questions",
        desc: "Get all questions with their tags and answers",
        cypher_dynamic_query: "MATCH (q:Question)-[:HAS_TAG]->(t:Tag) OPTIONAL MATCH (a:Answer)-[:ANSWERS]->(q) RETURN q.id, q.content, t.name as tag, COLLECT(a {.id, .content}) as answers",
        meta_data_swagger_docs: {
          method: "GET",
          url: "/api/questions",
          params: [],
          required_params: [],
          examples: [ { response: [ { id: "uuid", content: "What is 2+2?", tag: "Math", answers: [] } ] } ],
          is_deprecated: false
        }
      },
      {
        entity_type: "questions",
        desc: "Get questions by tag",
        cypher_dynamic_query: "MATCH (q:Question)-[:HAS_TAG]->(t:Tag {name: $tag}) OPTIONAL MATCH (a:Answer)-[:ANSWERS]->(q) RETURN q.id, q.content, t.name as tag, COLLECT(a {.id, .content}) as answers",
        meta_data_swagger_docs: {
          method: "GET",
          url: "/api/questions/by_tag/{tag}",
          params: [ "tag" ],
          required_params: [ "tag" ],
          examples: [ { request: { tag: "Math" }, response: [ { id: "uuid", content: "What is 2+2?", tag: "Math", answers: [] } ] } ],
          is_deprecated: false
        }
      },
      {
        entity_type: "questions",
        desc: "Create a new question with tag",
        cypher_dynamic_query: "MERGE (t:Tag {name: $tag}) CREATE (q:Question {id: randomUUID(), content: $content})-[:HAS_TAG]->(t) RETURN q.id, q.content",
        # cypher_dynamic_query: query = """
        # MERGE (t:Tag {name: $tag})
        # CREATE (q:Question {id: randomUUID(), content: $content})-[:HAS_TAG]->(t)
        # WITH q
        # UNWIND $answers AS ans
        # CREATE (a:Answer {id: randomUUID(), content: ans.content})-[:ANSWERS]->(q)
        # RETURN q.id AS id, q.content AS content
        # """,
        # await session.run(
        #   "CREATE (q:Question {question_id:$qid, content:$content,"
        #   " year:$year, exam_name:$exam_name, created_at:$now,"
        #   " like_count:0, dislike_count:0})",
        #   qid=qid, content=content,
        #   year=year, exam_name=exam_name,
        #   now=datetime.utcnow().isoformat()
        # )
        meta_data_swagger_docs: {
          method: "POST",
          url: "/api/questions",
          params: [ "content", "tag" ],
          required_params: [ "content", "tag" ],
          examples: [ { request: { content: "What is 3+3?", tag: "Math" }, response: { id: "uuid", content: "What is 3+3?" } } ],
          is_deprecated: false
        }
      },
      # Answer queries
      {
        entity_type: "answers",
        desc: "Add answer to question",
        cypher_dynamic_query: "MATCH (q:Question {id: $question_id}) CREATE (a:Answer {id: randomUUID(), content: $content})-[:ANSWERS]->(q) RETURN a.id, a.content",
        meta_data_swagger_docs: {
          method: "POST",
          url: "/api/questions/{question_id}/answers",
          params: [ "question_id", "content" ],
          required_params: [ "question_id", "content" ],
          examples: [ { request: { question_id: "uuid", content: "6" }, response: { id: "uuid", content: "6" } } ],
          is_deprecated: false
        }
      },
      {
        entity_type: "answers",
        desc: "Get all answers for a question",
        cypher_dynamic_query: "MATCH (a:Answer)-[:ANSWERS]->(q:Question {id: $question_id}) RETURN a.id, a.content",
        # cypher_dynamic_query: query = """
        #   MATCH (q:Question)-[:HAS_TAG]->(t:Tag)
        #   OPTIONAL MATCH (a:Answer)-[:ANSWERS]->(q)
        #   RETURN q.id AS id, q.content AS content, t.name AS tag, COLLECT(a { .id, .content }) AS answers
        # """,
        meta_data_swagger_docs: {
          method: "GET",
          url: "/api/questions/{question_id}/answers",
          params: [ "question_id" ],
          required_params: [ "question_id" ],
          examples: [ { request: { question_id: "uuid" }, response: [ { id: "uuid", content: "6" } ] } ],
          is_deprecated: false
        }
      },
      # Tag queries
      {
        entity_type: "tags",
        desc: "Get all tags",
        cypher_dynamic_query: "MATCH (t:Tag) RETURN t.name",
        meta_data_swagger_docs: {
          method: "GET",
          url: "/api/tags",
          params: [],
          required_params: [],
          examples: [ { response: [ { name: "Math" }, { name: "Science" } ] } ],
          is_deprecated: false
        }
      },
      {
        entity_type: "tags",
        desc: "Get tag hierarchy",
        cypher_dynamic_query: "MATCH (t:Tag)-[:PARENT_TAG*0..]->(parent:Tag) WHERE t.name = $tag RETURN t.name, COLLECT(parent.name) as hierarchy",
        meta_data_swagger_docs: {
          method: "GET",
          url: "/api/tags/{tag}/hierarchy",
          params: [ "tag" ],
          required_params: [ "tag" ],
          examples: [ { request: { tag: "Addition" }, response: { name: "Addition", hierarchy: [ "Math" ] } } ],
          is_deprecated: false
        }
      },
      # Comment queries
      {
        entity_type: "comments",
        desc: "Get all comments for a question",
        cypher_dynamic_query: "MATCH (c:Comment)-[:COMMENTS_ON]->(q:Question {id: $question_id}) RETURN c.id, c.text, c.user_id, c.created_at",
        meta_data_swagger_docs: {
          method: "GET",
          url: "/api/questions/{question_id}/comments",
          params: [ "question_id" ],
          required_params: [ "question_id" ],
          examples: [ { request: { question_id: "uuid" }, response: [ { id: "uuid", text: "Great question!", user_id: "user123", created_at: "2024-01-01T00:00:00Z" } ] } ],
          is_deprecated: false
        }
      },
      {
        entity_type: "comments",
        desc: "Create comment on question",
        cypher_dynamic_query: "MATCH (q:Question {id: $question_id}) CREATE (c:Comment {id: randomUUID(), text: $text, user_id: $user_id, created_at: datetime()})-[:COMMENTS_ON]->(q) RETURN c.id, c.text",
        meta_data_swagger_docs: {
          method: "POST",
          url: "/api/questions/{question_id}/comments",
          params: [ "question_id", "text", "user_id" ],
          required_params: [ "question_id", "text", "user_id" ],
          examples: [ { request: { question_id: "uuid", text: "Great question!", user_id: "user123" }, response: { id: "uuid", text: "Great question!" } } ],
          is_deprecated: false
        }
      },
      # Relation queries
      {
        entity_type: "relations",
        desc: "Get all relationship types",
        cypher_dynamic_query: "CALL db.relationshipTypes() YIELD relationshipType RETURN relationshipType",
        meta_data_swagger_docs: {
          method: "GET",
          url: "/api/relations",
          params: [],
          required_params: [],
          examples: [ { response: [ { relationshipType: "HAS_TAG" }, { relationshipType: "ANSWERS" } ] } ],
          is_deprecated: false
        }
      },
      {
        entity_type: "entities",
        desc: "Get all node labels/entities",
        cypher_dynamic_query: "CALL db.labels() YIELD label RETURN label",
        meta_data_swagger_docs: {
          method: "GET",
          url: "/api/entities",
          params: [],
          required_params: [],
          examples: [ { response: [ { label: "Question" }, { label: "Answer" }, { label: "Tag" } ] } ],
          is_deprecated: false
        }
      }
    ]
  end

  private

  def graph_db
    Neo4jDriver.session
  end
end
