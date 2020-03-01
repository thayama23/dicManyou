FactoryBot.define do
  factory :task do
    name { 'test_title' }
    detail { 'test_content' }
  end

  factory :second_task, class: Task do
   name { 'Factoryで作ったデフォルトのタイトル２' }
   detail { 'Factoryで作ったデフォルトのコンテント２' }
 end
end
