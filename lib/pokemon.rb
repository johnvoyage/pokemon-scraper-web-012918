require 'sqlite3'
require 'pry'

# db = SQLite3::Database.new('../db/pokemon.db')

class Pokemon

  attr_accessor :name, :type, :db, :id, :hp

  # @@all

  def initialize(name, type = nil, hp = nil, db = nil)

    @name = name
    @type = type
    @db = db
    @hp = hp
    # @@all << self
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon
      (name, type, id) VALUES
      (?, ?, ?)",
      name, type)
    # binding.pry
  end

  def self.find(id, db)
    pokemon_arr = db.execute("
      SELECT *
      FROM pokemon
      WHERE id = (?)", id
    )[0]
    # binding.pry
    pokemon = Pokemon.new(pokemon_arr[1], pokemon_arr[2], pokemon_arr[3], db)
    pokemon.id = pokemon_arr[0]
    pokemon
    # binding.pry
  end

  # def self.all
  #   @@all
  # end

  def alter_hp(new_hp, db)
    db.execute("
      UPDATE pokemon
      SET hp = ?
      WHERE id = ?",
      new_hp, self.id)
    # binding.pry
    db.execute("
      SELECT hp
      FROM pokemon
      WHERE id = ?",
      self.id)[0][0]
  end

end
