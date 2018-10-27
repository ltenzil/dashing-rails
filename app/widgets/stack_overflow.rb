require 'net/http'

class StackOverflow
  def initialize()
    @api = "https://api.stackexchange.com/2.2/questions?site=stackoverflow"
  end

  def list_questions
    response = HTTParty.get(@api)
    docs = JSON.parse(response.body)
    repos = [];
    docs.each do |doc|
      puts doc
      news_headline = QuestionDetailsBuilder.BuildFrom(doc[1])
      repos.push(news_headline)
    end
    repos
  end
end

class QuestionDetailsBuilder
  def self.BuildFrom(user)
    {
      user_name: (user[1]["owner"]["display_name"] rescue " "),
      reputation: (user[1]["owner"]["reputation"] rescue " "),
      title: (user[1]["title"] rescue " ")
    }
  end
end

