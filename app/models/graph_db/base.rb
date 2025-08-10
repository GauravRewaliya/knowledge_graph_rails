module GraphDB
  class Base
    # include Neo4j::ActiveBase

    # Basic
    def self.create(data)
      
    end
    def self.update(id, data)
      
    end
    def self.delete(id)
      
    end

    def self.get_relations
      ["xzy": ["Table1", "Table2"], "abc": ["Table3", "Table4"]]
    end
    def self.get_only_relations
      self.get_relations.keys()
    end
    def self.connect_tables
      ["Table1", "Table2"]
    end
    def self.query_table(query)# Declare Retrun type # TODO
      graph_cypher = ""
      return "Test"
    end

    # Base doc's
    """
    
    """
  end
end