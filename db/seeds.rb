# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# User.delete_all
Club.delete_all
Deposit.delete_all
Transaction.delete_all
Vote.delete_all
Request.delete_all

user1 = User.create(email: 'greg@gmail.com')
user2 = User.create(email: 'joe@gmail.com')
user3 = User.create(email: 'kim@gmail.com')


club1 = Club.create(name: 'Huntington Management')

deposit1 = Deposit.create(user_id: 2, club_id: club1.id, amount: 10000, date: Date.new(2013,1,5))
deposit1 = Deposit.create(user_id: 3, club_id: club1.id, amount: 10000, date: Date.new(2013,1,10))
deposit1 = Deposit.create(user_id: 4, club_id: club1.id, amount: 10000, date: Date.new(2013,1,20))

Transaction.create(club_id: club1.id, symbol: 'GOOG', price: 810.31, quantity: 10, date: Date.new(2013,1,22))
Transaction.create(club_id: club1.id, symbol: 'AAPL', price: 501.19, quantity: 10, date: Date.new(2013,2,1))
Transaction.create(club_id: club1.id, symbol: 'VMW', price: 80.31, quantity: 10, date: Date.new(2013,1,22))
Transaction.create(club_id: club1.id, symbol: 'CTSH', price: 78.31, quantity: 10, date: Date.new(2013,1,23))
  create_table "transactions", :force => true do |t|
    t.integer  "club_id"
    t.decimal  "price"
    t.float    "quantity"
    t.string   "symbol"
    t.date     "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "request_id"

Request.create(club_id: 2, date: Date.new(2013,1,21), price: 900, quantiy: 10, symbol: 'GOOG', user_id: 2, message: 'Future of technology', status: 'pending' )
Request.create(club_id: 2, date: Date.new(2013,1,22), price: 550, quantiy: 10, symbol: 'AAPL', user_id: 3, message: 'Huge cash reserves', status: 'approved' )
Request.create(club_id: 2, date: Date.new(2013,1,20), price: 90, quantiy: 10, symbol: 'VMW', user_id: 4, message: 'Virtualization and cloud are hot', status: 'approved' )
Request.create(club_id: 2, date: Date.new(2013,1,19), price: 100, quantiy: 10, symbol: 'CTSH', user_id: 2, message: 'Strong revenue growth', status: 'rejected' )

Vote.create()
  create_table "requests", :force => true do |t|
    t.date     "date"
    t.decimal  "price"
    t.float    "quantity"
    t.string   "symbol"
    t.integer  "user_id"
    t.integer  "club_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "message"
    t.string   "status"
  end

  create_table "votes", :force => true do |t|
    t.integer  "request_id"
    t.integer  "user_id"
    t.integer  "club_id"
    t.boolean  "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false

