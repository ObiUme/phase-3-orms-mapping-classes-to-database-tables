class Song

  attr_accessor :name, :album, :id

  def initialize(name:, album:, id: nil)
    @id = id
    @name = name
    @album = album
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

  def save 
    sql = <<-SQL
    INSERT INTO songs (name, album)
    VALUES (?, ?)
    SQL

    # insert the song
    DB[:conn].execute(sql, self.name, self.album)

    # get the song ID from the database and save it to the Ruby instance
    self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]

    self
  end

    def self.create(name:, album:)
      song = Song.new(name: name, album: album)
      song.save
    end



end

# Instantiating a new instance of the Song class.
# Inserting a new row into the database table that contains the information regarding that instance.
# Grabbing the id of that newly inserted row and assigning the given Song instance's id attribute equal to the id of its associated database table row.