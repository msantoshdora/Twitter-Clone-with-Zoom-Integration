module MicropostsHelper
	def get_date(datetime)
		res = datetime.split('T')
		date = res[0]
	end
	def get_time(datetime)
		res = datetime.split('T')
		time = res[1]
	end
end
