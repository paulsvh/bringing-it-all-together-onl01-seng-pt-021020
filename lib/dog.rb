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
