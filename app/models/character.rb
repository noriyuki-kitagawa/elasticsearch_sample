class Character < ActiveHash::Base
  self.data = [
    { id: 1, name: '優しい' },
    { id: 2, name: '男らしい' },
    { id: 3, name: 'ユニーク' },
  ]
end
