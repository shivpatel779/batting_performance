class HomesController < ApplicationController

	def index
		@all_battings = Batting.all

		# battings with year and team name
		@all_battings = @all_battings.where("year_id = ?", params[:year]) if params[:year].present?
		@all_battings = @all_battings.where("lower(team_name) LIKE ?", "%#{params[:team_name].downcase}%") if params[:team_name].present?
		@battings = @all_battings

		if Batting.first.present?
			@batting_years = Batting.all.collect(&:year_id).uniq
			unless Batting.first.team_name.present?
				flash[:notice] = "Please Import TEAM CSV."
			end
		end
	end

	# batting csv page
	def batting_csv
	end

	# team csv page
	def teams_csv
		unless Batting.first.present?
			flash[:notice] = "Please Import Batting CSV first."
			redirect_to root_path
		end
	end

	# import batting csv
	def import_batting_csv
		file = params.require(:file)
		Batting.import(file)
		redirect_to root_path
	end

	# import team csv
	def import_teams_csv
		file = params.require(:file)
		Batting.import_team(file)
		redirect_to root_path
	end
end
