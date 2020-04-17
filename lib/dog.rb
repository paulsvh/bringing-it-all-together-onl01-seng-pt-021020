require_relative "../config/environment.rb"

class Dog
attr_accessor :name, :breed
attr_reader :id

  def initialize(id: nil, name:, breed:)
    @id = id
    @name = name
    @breed = breed
  end

  def self.create_table
    sql = <<-SQL
      create table if not exists dogs (
        id integer primary key,
        name text,
        breed text
      )
      SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute("drop table dogs")
  end

  def save
    if self.id
      self.update
    else
    sql = <<-SQL
      insert into dogs (name, breed)
      values (?, ?)
      SQL
    DB[:conn].execute(sql, self.name, self.breed)
    @id = DB[:conn].execute("select last_insert_rowid() from students")[0][0]
    end
    self
  end

  def self.create(name:, breed:)
    new_dog = self.new(name, breed)
    new_dog.save
    new_dog
  end

  def self.new_from_db(row)
    id = row[0]
    name = row[1]
    breed = row[2]
    new_dog = self.new(id, name, breed)
    new_dog
  end

  def self.find_by_id(id)
    id_find = DB[:conn].execute("select * from dogs where id = ?")[0]
    new_dog = self.new(id_find[0], id_find[1], id_find[2])
    new_dog
  end





end
