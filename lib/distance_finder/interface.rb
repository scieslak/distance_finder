module DistanceFinder
  class Interface

    @@line_length = 60
    @@right_margin = 3
    @@result_ljust = 15

    # Displays welcome information and help
    def self.welcome
      puts divider("Welcome to DistanceFinder!")

      text = "Get distance and travel time between almost any two places on the globe.DistanceFinder uses powerful Google API to deliver reliable results fast and without unnecessary baggage."

      format_text(text).each {|line| puts line.center(@@line_length)}

      puts "\n"

      # Display help
      help
    end

    # Receives input data and returns route details
    def self.calculate
      origin = nil
      destination = nil

      loop do

        print margin + "⊗ Insert origin:> "
        origin = gets.chomp
        bye if origin == "quit"

        print margin + "⊗ Insert destination:> "
        destination = gets.chomp
        bye if destination == "quit"


        route = DistanceFinder::Calculator.new(origin, destination)

        puts divider

        if route.status == "OK"
          puts format_result("⊗ Origin:", route.start_address)
          puts format_result("⊗ Destination:", route.end_address)
          puts format_result("⇄ Distance:", route.distance.round(1).to_s + "miles")
          puts format_result("🕑 Travel time:", route.duration)
        else
          puts format_result("Sorry, unable to find the route.")
          puts format_result("Status: " + route.status.upcase)
        end

        puts divider

      end

    end

    #Displays help
    def self.help
      puts divider("Help")
      puts "Possible input formats:"

      input_formats = [
        "[TOWN]",
        "[STREET] [TOWN]",
        "[HOUSE NUMBER] [STREET] [TOWN]",
        "[HOUSE NUMBER] [STREET] [TOWN] [COUNTRY]",
        "[HOUSE NUMBER] [STREET] [TOWN] [COUNTRY] [POST CODE]",
        "[STREET] [TOWN] [COUNTRY] [POST CODE]",
        "[TOWN] [COUNTRY] [POST CODE]",
        "[COUNTRY] [POST CODE]",
        "[POST CODE]",
        "",
        "`quit` for exit."
      ]
      input_formats.each {|input| puts " ".ljust(3) + input}
      puts divider
    end

    # Exits application
    def self.bye
      puts divider("Thanks, See you next time, Bye!")
      exit
    end

    ############# helper methods

    # Sets margine value
    def self.margin
      "".ljust(@@right_margin)
    end

    # Returns divider string
    def self.divider(text="***")
      text_length = text.length
      hash_count = (@@line_length - text_length - 2) / 2
      print_hash = '#' * hash_count
      pretty_text = "#{print_hash} #{text} #{print_hash}"
      pretty_text << '#' if pretty_text.length == (@@line_length - 1)
      "\n #{pretty_text.center(@@line_length)}\n\n"
    end

    # Returns array of lines of set length
    def self.format_text(text)
      text.scan /\S.{1,#{@@line_length}}(?!\S)/
    end

    def self.format_result(label, value="")
        margin + label.ljust(@@result_ljust) + value
    end
  end
end
