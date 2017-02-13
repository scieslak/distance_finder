require "distance_finder/version"
require "distance_finder/calculator"
require "net/http"
require "json"

module DistanceFinder

 class Guide

   def self.welcome
     puts "Welcome to DistanceFinder. Get travel time and distance between any two addresses on the globe. DistanceFinder uses powerful Google API to deliver reliable results fast without unnecessary baggage."

     puts "Insert orgin:"
     print "> "
     origin = gets.chomp
     exit if origin == "exit"
     puts "Insert destination:"
     print "> "
     destination = gets.chomp

     route = Calculator.new(origin, destination)

     puts "Origin: #{route.start_address}"
     puts "Destination: #{route.end_address}"
     puts "Distance: #{route.distance}"
     puts "Travel time: #{route.duration}"



   end

 end


end
