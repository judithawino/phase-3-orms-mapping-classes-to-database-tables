class Song

  attr_accessor :name, :album, :id

  def initialize(name:, album:, id: nil)
    # id is set to nil allowing new song instance that do not have id value. id value is assigned by the database when it is saved.
    @name = name
    @album = album
    @id = id
  end
# class method because it is the class's job as a whole to create a table that it is mapped to
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
  # instance method that inserts data to the table
  def save
    sql = <<-SQL
    INSERT INTO songs 
    (name, album) 
    VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.album)
    set_id
  end
  def set_id
    sql = "SELECT last_insert_rowid() FROM songs"
    retrieved_id = DB[:conn].execute(sql)
    self.id = retrieved_id [0][0]
  end

  def self.create(name:, album:)
    song = Song.new(name: name, album: album)
    song.save
  end  
end


