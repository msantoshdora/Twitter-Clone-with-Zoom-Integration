#!/usr/bin/ruby

require 'uri'
require 'net/http'
require 'json'


class Zoom

	def create_user(email)
		payload = {"iss": "_A9fL2rmTfSeZD7eVwv-0A", "exp": 1580198539} #API Key
  		token=JWT.encode(payload, 'y5E9U9E9gizPaVCrNanNoHKn0AxFj0mFU5lC') #API Secret
  		#email = "santoshcrj97@gmail.com"
		url = URI("https://api.zoom.us/v2/users")
   		http = Net::HTTP.new(url.host, url.port)
   		http.use_ssl = true
   		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
   		request = Net::HTTP::Post.new(url)
   		request["authorization"] = "Bearer #{token}"
   		request["content-type"] = 'application/json'


		request.body = JSON.dump({
  				"action" => "create",
  				"user_info" => {
    				"email" => "#{email}",
   					"type" => "1"
 				 }
		})

		response = http.request(request)
		puts response.read_body
	end

	 def display
	 	puts "Hello Ruby!"
	 end

	def create_meeting(userId,title,time)
		time = time+":00Z"
		#email = "santosh.dora@chronus.com"
		payload = {"iss": "_A9fL2rmTfSeZD7eVwv-0A", "exp": 1580198539} #API Key
  		token=JWT.encode(payload, 'y5E9U9E9gizPaVCrNanNoHKn0AxFj0mFU5lC') #API Secret
		#url = URI("https://api.zoom.us/v2/users/:userId/meetings")
		url = URI("https://api.zoom.us/v2/users/#{userId}/meetings")
   		http = Net::HTTP.new(url.host, url.port)
   		http.use_ssl = true
   		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
   		request = Net::HTTP::Post.new(url)
   		request["authorization"] = "Bearer #{token}"
   		request["content-type"] = 'application/json'

#2019-07-12T20:28:00Z
		request.body = JSON.dump({
			"topic": "#{title}",
			"type": "1",
			"start_time": "#{time}",
			"duration": "20",
			"settings": {
				"host_video": "false",
				"participant_video": "false",
				"join_before_host": "false"
			}

		})

		response = http.request(request)
		body_content = response.read_body
		#puts response.read_body
		#puts JSON.parse(body_content)['join_url']

		return JSON.parse(body_content)['join_url']
	end
end