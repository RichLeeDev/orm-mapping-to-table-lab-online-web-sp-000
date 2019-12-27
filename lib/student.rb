class Student
  attr_accessor name, grade,
  attr_reader id,
  
  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end
  
  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS songs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        album TEXT
        )
        SQL
      DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = <<-SQL 
      DROP TABLE songs
      SQL
    DB[:conn].execute(sql)
  end
  
  def save
    sql = <<-SQL
      INSERT INTO songs (name, album)
      VALUES(?, ?)
      SQL
      
      DB[:conn].execute(sql, self.name, self.album)
    
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]  
  end
  
  def self.create(name, grade)
    song = Song.new(name, grade)
    song.save
    song
  end 
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
end
