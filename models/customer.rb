require_relative("../db/sql_runner")

class Customer

    attr_reader :id
    attr_accessor :name, :funds

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @name = options['name']
        @funds = options['funds'].to_i
    end

    def save()
        sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
        values = [@name, @funds]
        customer = SqlRunner.run(sql, values).first
        @id = customer['id'].to_i
    end

    def self.find(id)
        sql = "SELECT * FROM customers WHERE id = $1"
        values = [id]
        customer = SqlRunner.run(sql, values).first
        return Customer.new(customer)
    end
    
    def self.all()
        sql = "SELECT * FROM customers"
        customers = SqlRunner.run(sql)
        return self.map_items(customers)
    end

    def update()
        sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
        values = [@name, @funds, @id]
        SqlRunner.run(sql, values)
    end
    
    def delete()
        sql = "DELETE FROM customers WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end
    
    def self.delete_all()
        sql = "DELETE FROM customers"
        SqlRunner.run(sql)
    end
    
    def films()
        sql = "SELECT films.* FROM films INNER JOIN tickets ON tickets.film_id = films.id WHERE film_id = $1"
        values = [@id]
        films = SqlRunner.run(sql, values)
        return Film.map_items(films)
    end
    
      def self.map_items(data)
        return data.map {|customer| Customer.new(customer)}
      end
end