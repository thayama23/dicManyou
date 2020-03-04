require 'rails_helper'

RSpec.describe Task, type: :model do
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
end
