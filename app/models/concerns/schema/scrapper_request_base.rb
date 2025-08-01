class ScrapperRequestBase
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :url, :string
  attribute :headers, :hash, default: -> { {} }
  attribute :cookie, :string, default: ""
  attribute :body, :hash, default: -> { {} }
  attribute :method, :string

  def self.from_hash(hash)
    new(
      url: hash["url"],
      headers: hash["headers"] || {},
      cookie: hash["cookie"] || "",
      body: hash["body"] || {},
      method: hash["method"]
    )
  end

  def as_json(*)
    {
      url: url,
      headers: headers,
      cookie: cookie,
      body: body,
      method: method
    }
  end
end