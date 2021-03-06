require_relative("../db/sql_runner")

class Film

    attr_reader :id
    attr_accessor :title, :price

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @title = options['title']
        @price = options['price'].to_i
    end

    def save()
        sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
        values = [@title, @price]
        film = SqlRunner.run(sql, values).first
        @id = film['id'].to_i
    end

    def find(id)
        sql = "SELECT * FROM films WHERE id = $1"
        values = [id]
        film = SqlRunner.run(sql, values).first
        return Film.new(film)
    end

    def self.find_price(title)
        sql = "SELECT price FROM films WHERE title = $1"
        values = [title]
        film = SqlRunner.run(sql, values).first
        return film['price'].to_i
    end

    def self.find_id(title)
        sql = "SELECT id FROM films WHERE title = $1"
        values = [title]
        film = SqlRunner.run(sql, values).first
        return film['id'].to_i
    end
    
    def self.all()
        sql = "SELECT * FROM films"
        films = SqlRunner.run(sql)
        return self.map_items(films)
    end

    def update()
        sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
        values = [@title, @price, @id]
        SqlRunner.run(sql, values)
    end
    
    def delete()
        sql = "DELETE FROM films WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end
    
    def self.delete_all()
        sql = "DELETE FROM films"
        SqlRunner.run(sql)
    end
    
    def customers()
        sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE film_id = $1"
        values = [@id]
        customers = SqlRunner.run(sql, values)
        return Customer.map_items(customers)
    end

    def customers_to_i()
        sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE film_id = $1"
        values = [@id]
        customers = SqlRunner.run(sql, values)
        return customers.count
    end
    
    def self.map_items(data)
        return data.map {|film| Film.new(film)}
    end

      
end