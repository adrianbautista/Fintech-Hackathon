User.delete_all
Club.delete_all
Deposit.delete_all
Transaction.delete_all
Vote.delete_all
Request.delete_all

user2 = User.create(email: 'chris@gmail.com', name: 'Chris Goodmacher', provider: 'facebook', uid: '1235', password: 'password', image: 'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-snc6/c127.37.466.466/s160x160/269848_708986977256_5823215_n.jpg' )
user3 = User.create(email: 'jon@gmail.com', name: 'Jon Ku', provider: 'facebook', uid: '1236', password: 'password', image: 'https://profile-b.xx.fbcdn.net/hprofile-snc7/c46.46.569.569/s160x160/578031_10100761306312859_528556489_n.jpg' )
user1 = User.create(email: 'thomas@gmail.com', name: 'Thomas Yang', provider: 'facebook', uid: '1238', password: 'password', image: 'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-snc7/c42.42.532.532/s160x160/600219_10100238761477045_985486861_n.jpg' )

club1 = Club.create(name: 'Huntington Management')

deposit1 = Deposit.create(user_id: user1.id, club_id: club1.id, amount: 10000, date: Date.new(2013,1,5))
deposit2 = Deposit.create(user_id: user2.id, club_id: club1.id, amount: 10000, date: Date.new(2013,1,10))
deposit3 = Deposit.create(user_id: user3.id, club_id: club1.id, amount: 10000, date: Date.new(2013,1,20))

Transaction.create(club_id: club1.id, symbol: 'GOOG', price: 702.87, quantity: 6, date: Date.new(2013,1,22))
Transaction.create(club_id: club1.id, symbol: 'AAPL', price: 453.62, quantity: 30, date: Date.new(2013,2,1))
Transaction.create(club_id: club1.id, symbol: 'VMW', price: 92.78, quantity: 60, date: Date.new(2013,1,22))
Transaction.create(club_id: club1.id, symbol: 'CTSH', price: 77.76, quantity: 3, date: Date.new(2013,1,23))

request1 = Request.create(club_id: 2, date: Date.new(2013,1,24), price: 750, quantity: -10, symbol: 'GOOG', user_id: 2, message: 'Future of technology', status: 'pending' )
request3 = Request.create(club_id: 2, date: Date.new(2013,1,20), price: 100, quantity: 10, symbol: 'C', user_id: 2, message: 'Wall street is back', status: 'pending' )
# request4 = Request.create(club_id: 2, date: Date.new(2013,4,4), price: 9.23, quantity: 10, symbol: 'NYT', user_id: 2, message: 'Strong revenue growth', status: 'rejected' )
# request2 = Request.create(club_id: 2, date: Date.new(2013,2,22), price: 550, quantity: -10, symbol: 'AAPL', user_id: 3, message: 'Huge cash reserves', status: 'rejected' )

Vote.create(request_id: request1.id, user_id: user1.id, club_id: club1.id, value: true)
Vote.create(request_id: request1.id, user_id: user2.id, club_id: club1.id, value: false)
Vote.create(request_id: request1.id, user_id: user3.id, club_id: club1.id)
Vote.create(request_id: request3.id, user_id: user2.id, club_id: club1.id, value: true)
Vote.create(request_id: request3.id, user_id: user1.id, club_id: club1.id)
Vote.create(request_id: request3.id, user_id: user1.id, club_id: club1.id)
