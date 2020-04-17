require_relative "../config/environment.rb"

class Dog
attr_accessor :name, :breed
attr_reader :idea

  def initialize(id = nil, name:, breed:)
    @id = idea
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




end
