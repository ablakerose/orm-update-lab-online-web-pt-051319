require_relative "../config/environment.rb"

class Student
  attr_accessor :name, :grade, :id

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
      sql =  <<-SQL
        CREATE TABLE IF NOT EXISTS students (
          id INTEGER PRIMARY KEY,
          name TEXT,
          grade TEXT
          )
          SQL
      DB[:conn].execute(sql)
    end

    def save
  if self.id
    self.update
  else
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.album)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
  end
end

    def self.create(name:, grade:)
      student = Student.new(name, grade)
      student.save
      student
    end

    def self.find_by_name(name)
      sql = "SELECT * FROM students WHERE name = ?"
      result = DB[:conn].execute(sql, name)[0]
      Student.new(result[0], result[1], result[2])
      end
  end
