require "pry"
class Pokemon

  attr_reader :id, :name, :type, :db
  attr_accessor :hp

  def initialize(id:, name:, type:, db: nil, hp: nil)
    @id = id
    @name = name
    @type = type
    @hp = hp
    @db = db
  end

  def self.save(name,type, db)
    sql = "INSERT INTO pokemon (name, type) VALUES (?, ?);"
    db.execute(sql, name, type)
  end

  def self.find(id, db)
    sql = "SELECT * FROM pokemon WHERE id = ? LIMIT 1;"
    db.execute(sql, id).map do |row|
      self.new_from_db(row)
    end.first
  end

  def self.new_from_db(row)
    pokemon = Pokemon.new(id: row[0], name: row[1], type: row[2])
  end

  def alter_hp(new_hp, db)
    db.execute("UPDATE pokemon SET hp = ? WHERE id = ?;", new_hp, self.id)
    binding.pry
    self.hp = new_hp
  end

end
