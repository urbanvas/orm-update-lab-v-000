require_relative "../config/environment.rb"

class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(id=nil, name, grade)
    @id = id
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = <<-SQL
          CREATE TABLE IF NOT EXISTS students (
            id INTEGER PRIMARY KEY,
            name TEXT,
            grade INTEGER
          )
          SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
          DROP TABLE IF EXISTS students
          SQL
    DB[:conn].execute(sql)
  end

  def save
    if self.id
      self.update
    else
      sql = <<-SQL
      INSERT INTO songs (name, album)
      VALUES (?, ?)
      SQL
    DB[:conn].execute(sql, self.name, self.album)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
    end
  end

  def self.create(name:, grade:)
    a = Student.new(name, grade)
    a.save
    a
  end



end
