class LogsController < ApplicationController
	def index
		@logs = []

		User.all.each do |user|
			user.logs.each do |log|
				@logs << { "#{user.email}" => log }
			end
		end

		@logs = @logs.sort_by { |user| user.values.last.created_at }.reverse
	end
end
