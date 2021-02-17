class Batting < ApplicationRecord
	scope :sort_with_average, -> {order(batting_average: :desc)}

	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			batting         = self.find_or_create_by(player_id: row['playerID'], year_id: row['yearID'], team_id: row['teamID'])
			batting.stint   = row['stint']
			batting.ab      = row['AB']
			batting.h       = row['H']
			batting.batting_average = (batting.h.to_f/batting.ab.to_f).round(3)
			batting.save
		end
	end

	def self.import_team(file)
		CSV.foreach(file.path, headers: true) do |row|
			Batting.where(team_id: row['teamID']).update_all(team_name: row['name'])
		end
	end
end
