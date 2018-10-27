current_valuation = 0

Dashing.scheduler.every '20s' do
  last_valuation = current_valuation
  current_valuation = rand(100)

  Dashing.send_event('valuation', { current: current_valuation, last: last_valuation })
  Dashing.send_event('synergy',   { value: rand(100) })
end



@BBC_News = BbcNews.new()


Dashing.scheduler.every '59s', :first_in => 0 do |job|
  headlines = @BBC_News.latest_headlines
  Dashing.send_event('news', { :headlines => headlines})
end

@questions = StackOverflow.new
Dashing.scheduler.every '15s', :first_in => 0 do |job|
  headlines = @questions.list_questions
  Dashing.send_event('myrepos', { :headlines => headlines})
end