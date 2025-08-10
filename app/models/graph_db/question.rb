module GraphDB
  class Question < GraphDB::Base

    # # Define the properties of the Question node
    # property :content, type: String
    # t.json :meta_data
    # t.json :options
    # t.string :tags
    # property :correct_option, :string
    # property :created_at, type: DateTime, default: -> { DateTime.now }
    # property :updated_at, type: DateTime, default: -> { DateTime.now }

    # # Define relationships
    # has_many :out, :answers, type: :ANSWERED_BY, model_class: 'GraphDB::Answer'
    def add_question(question_data: QuestionRequest)
      query = """
        MERGE (t:Tag {name: $tag})
        CREATE (q:Question {id: randomUUID(), content: $content})-[:HAS_TAG]->(t)
        WITH q
        UNWIND $answers AS ans
        CREATE (a:Answer {id: randomUUID(), content: ans.content})-[:ANSWERS]->(q)
        RETURN q.id AS id, q.content AS content
      """
      result = await kg.run(query, tag=question.tag, content=question.content, answers=[a.dict() for a in question.answers])
      return result.single()  
    end
    # await session.run(
    #   "CREATE (q:Question {question_id:$qid, content:$content,"
    #   " year:$year, exam_name:$exam_name, created_at:$now,"
    #   " like_count:0, dislike_count:0})",
    #   qid=qid, content=content,
    #   year=year, exam_name=exam_name,
    #   now=datetime.utcnow().isoformat()
    # )
    def add_answer_to_question(question_id, answer_data: AnswerRequest)
      query = """
        MATCH (q:Question {id: $question_id})
        CREATE (a:Answer {id: randomUUID(), content: $content})-[:ANSWERS]->(q)
        RETURN a.id AS id, a.content AS content
      """
      result = await kg.run(query, question_id=question_id, content=answer.content)
      return result.single()
    end
    def all_questions : List[QuestionResponse]
      query = """
        MATCH (q:Question)-[:HAS_TAG]->(t:Tag)
        OPTIONAL MATCH (a:Answer)-[:ANSWERS]->(q)
        RETURN q.id AS id, q.content AS content, t.name AS tag, COLLECT(a { .id, .content }) AS answers
      """
      return kg.run(query).map{|x| QuestionResponse(x.data())}
    end
    def fetch_questions_by_tag(tag_name)
      query = """
        MATCH (q:Question)-[:HAS_TAG]->(t:Tag {name: $tag})
        OPTIONAL MATCH (a:Answer)-[:ANSWERS]->(q)
        RETURN q.id AS id, q.content AS content, t.name AS tag, COLLECT(a { .id, .content }) AS answers
      """
      return kg.run(query, tag=tag_name).map{|x| QuestionResponse(x.data())}
    end
    def create_question(data)
      
    end
    def get_question(question_id)
      res = session.run(
        "MATCH (q:Question {question_id:$qid})"
        " OPTIONAL MATCH (q)-[:HAS_ANSWER]->(a)"
        " RETURN q, collect(a) as answers",
        qid=question_id
      )
      record = await res.single()
      if not record:
          return None
      q = record["q"]
      answers = record["answers"]
      return {
          "question_id": q["question_id"],
          "content": q["content"],
          "year": q["year"],
          "exam_name": q["exam_name"],
          "created_at": q["created_at"],
          "like_count": q["like_count"],
          "dislike_count": q["dislike_count"],
          "answers": [ {"answer_id": a["answer_id"], "content": a["content"]} for a in answers ]
      }
    end

    def update_question(question_id)
      
    end
    def delete_question(question_id)
      
    end

    def fetch_comments(question_id)
      
    end
    def fetch_answers(question_id)
      
    end
    def get_all_topics_herarchey(question_id)
      
    end

    def increment_like(label: str, node_id: str):
      reutrn session.run(
        f"MATCH (n:{label} {{{label.lower()}_id:$id}})"
        " SET n.like_count = n.like_count + 1",
        id=node_id
      )
    end
    
  end
end