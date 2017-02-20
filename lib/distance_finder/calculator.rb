module DistanceFinder
  class Calculator

    attr_reader :distance, :duration, :start_address, :end_address, :display_full_response

    def initialize(origin, destination)
      @origin = strip_input(origin)
      @destination = strip_input(destination)
      @google_object = parse_response
    end


    # Returns response
    def status
      @google_object["status"]
    end

    # Return distance
    def distance
      @google_object["routes"][0]["legs"][0]["distance"]["value"] / 1000 * 0.621371
    end

    # Return duration
    def duration
      @google_object["routes"][0]["legs"][0]["duration"]["text"]
    end

    # Return origin name
    def start_address
      @google_object["routes"][0]["legs"][0]["start_address"]
    end

    # Returns destination name
    def end_address
      @google_object["routes"][0]["legs"][0]["end_address"]
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
      "https://maps.googleapis.com/maps/api/directions/json?origin=#{@origin}&destination=#{@destination}"
    end

    def strip_input(string)
      ActiveSupport::Inflector.transliterate(string).strip()
    end

  end
end
