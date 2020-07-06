require_relative( 'models/customer' )
require_relative( 'models/film' )
require_relative( 'models/ticket' )

require( 'pry-byebug' )

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

customer1 = Customer.new({'name' => 'James', 'funds' => '30', 'tickets' => '1'})
customer1.save()

customer2 = Customer.new({'name' => 'Juan', 'funds' => '40', 'tickets' => '2'})
customer2.save()

film1 = Film.new({'title' => 'Black Dynamite', 'price' => '8'})
film1.save()

film2 = Film.new({'title' => 'Batman Begins', 'price' => '7'})
film2.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()

ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id})
ticket2.save()

binding.pry
nil