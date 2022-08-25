require 'bundler'
Bundler.require

require_relative '../lib/song'

DB = { conn: SQLite3::Database.new("db/music.db") }
# creating a new song instance
Song.create_table
kibali = Song.new(name: 'kibali', album: 'Florence Andenyi')
# saving the newly created song instance attributes to the database.
kibali.save
