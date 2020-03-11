require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "validation" do
    it 'nameが空ならバリデーションが通らない' do
      task = Task.new(name: '', detail: 'aaaa')
      expect(task).not_to be_valid
    end
    it 'detailが空ならバリデーションが通らない' do
      # ここに内容を記載する
      task = Task.new(detail: '', name: 'aaaa')
      expect(task).not_to be_valid
    end
    it 'nameとdetailに内容が記載されていればバリデーションが通る' do
      # ここに内容を記載する
      task = Task.new(
        name: 'hoge',
        detail: 'hogehoge'
      )
      expect(task).to be_valid
    end
  
    # it 'progressとpriorityに内容が記載されていればバリデーションが通る' do
    #   # ここに内容を記載する
    #   task = Task.new(
    #     progress: 無関係, 
    #     priority: 無関係
    #   )
    #   expect(task).not_to be_valid
    #   # expect(task).to be_valid
    # end
  end

  # describe ".admins" do
  #   it "includes users with admin flag" do
  #     admin = User.create!(admin: true)
  #     expect(User.admins).to include(admin)
  #   end

  #   it "excludes users without admin flag" do
  #     non_admin = User.create(admin: false)
  #     expect(User.admins).not_to include(non_admin)
  #   end


  describe "scope" do
    it 'to include task_name, aaaaa' do
      task_name = Task.create(name: "aaaaa")
      expect(Task.search_name("aaaaa")).to include Task.find_by(name: "aaaaa") 
    end 
      
    it 'to include task_progress, 完了' do
      task_progress = Task.create(progress: "完了")
      expect (Task.search_progress("完了")).to include Task.find_by(progress: "完了")
    end

  end
  # it 'nameが空ならバリデーションが通らない' do
  #   task = Task.new(name: '', detail: 'aaaa')
  #   expect(task).not_to be_valid
  # end
  # it 'detailが空ならバリデーションが通らない' do
  #   # ここに内容を記載する
  #   task = Task.new(detail: '', name: 'aaaa')
  #   expect(task).not_to be_valid
  # end
  # it 'nameとdetailに内容が記載されていればバリデーションが通る' do
  #   # ここに内容を記載する
  #   task = Task.new(
  #     name: 'hoge',
  #     detail: 'hogehoge'
  #   )
  #   expect(task).to be_valid
  # end

  # it 'progressとpriorityに内容が記載されていればバリデーションが通る' do
  #   # ここに内容を記載する
  #   task = Task.new(
  #     progress: 無関係, 
  #     priority: 無関係
  #   )
  #   expect(task).not_to be_valid
  #   # expect(task).to be_valid
  # end
end
