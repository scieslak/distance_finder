module DistanceFinder
  class Calculator

    attr_reader :distance, :duration, :start_address, :end_address, :display_full_response, :status

    def initialize(origin, destination, mode = "driving", units = "imperial")
      @origin = origin.strip()
      @destination = destination.strip()
      @mode = "mode=" + mode
      @units = "units=" + units
      @google_object = parse_response
      @error_msg = "Error!"
    end


    # Returns response
    def status
      @google_object["status"]
    end

    # Return distance
    def distance
      @google_object["routes"][0]["legs"][0]["distance"]["text"] ||= @error_msg
    end

    # Return duration
    def duration
      @google_object["routes"][0]["legs"][0]["duration"]["text"] ||= @error_msg
    end

    # Return origin name
    def start_address
      @google_object["routes"][0]["legs"][0]["start_address"] ||= @origin
    end

    # Returns destination name
    def end_address
      @google_object["routes"][0]["legs"][0]["end_address"] ||= @destination
    end

    # Generate pretty JSON for command line output
    def full_response
      puts JSON.pretty_generate(@google_object)
    end


    def parse_response
      if get_response.kind_of? Net::HTTPSuccess
        JSON.parse(get_response.body)
      elsif !get_response
        JSON.parse('{"status" : "No internet connection!"}')
      else
        JSON.parse('{"status" : "Google API unaviable!"}')
      end
    end

    # Checks for internet connection and gets response from Google API
    def get_response
      begin
        TCPSocket.new 'google.com', 80
        Net::HTTP.get_response(URI(build_url))
      rescue SocketError
        return false
      end
    end

    def build_url
      "https://maps.googleapis.com/maps/api/directions/json?origin=#{convert_input(@origin)}&destination=#{convert_input(@destination)}&#{@units}&#{@mode}"
    end



    # Converts non english characters into english equivalents
    # Replaces spaces with "+"
    def convert_input(string)
      ActiveSupport::Inflector.transliterate(string).strip().tr(" ", "+")
    end

  end
end
