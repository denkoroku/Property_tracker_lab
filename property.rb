require 'pg'
require 'pry'
class Property

attr_accessor :address, :value, :no_of_bedrooms, :build
attr_reader :id

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @address = details['address']
    @value = details['value'].to_i
    @no_of_bedrooms = details['no_of_bedrooms'].to_i
    @build = details['build']
  end


  def save
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "INSERT INTO properties (address, value, no_of_bedrooms, build)
    VALUES ($1, $2, $3, $4) RETURNING id"
    values = [@address, @value, @no_of_bedrooms, @build]
    db.prepare("save", sql)
    new_property = db.exec_prepared("save", values)
    @id = new_property[0]['id']
    db.close
  end

  def Property.all
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "SELECT * FROM properties"
    db.prepare("all", sql)
    properties = db.exec_prepared("all")
    db.close
    return properties.map { |property| Property.new(property) }
  end

  def Property.find_by_id(id)
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE id = $1"
    db.prepare("find", sql)
    values = [id]
    properties = db.exec_prepared("find", values)
    db.close
    return Property.new(properties[0])
  end

  def Property.find_by_address(address)
    address = "%#{address}%"
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE address LIKE $1"
    db.prepare("find", sql)
    values = [address]
    property = db.exec_prepared("find", values)
    db.close
    return property.map { |property| Property.new(property) }
  end

# FIND by exact address
  def Property.find_by_exact_address(address)
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE address = $1"
    db.prepare("find", sql)
    values = [address]
    property = db.exec_prepared("find", values)
    db.close
    return property.map { |property| Property.new(property) }
  end

  def update
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "UPDATE properties
          SET address = $1,
          value = $2,
          no_of_bedrooms = $3,
          build = $4 WHERE id = $5"
    db.prepare("update", sql)
    values = [@address, @value, @no_of_bedrooms, @build, @id]
    db.exec_prepared("update", values)
    db.close
  end

  def delete
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "DELETE FROM properties WHERE id = $1"
    db.prepare("delete", sql)
    values = [@id]
    db.exec_prepared("delete", values)
    db.close
  end

  def find(id)
    db = PG.connect({dbname: 'properties', host: 'localhost'})
  end


end
