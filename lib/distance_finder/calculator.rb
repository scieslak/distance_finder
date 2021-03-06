module DistanceFinder
  class Calculator

    attr_reader :status,
                :start_address,
                :end_address,
                :distance,
                :duration,
                :display_full_response

    def initialize(origin, destination, mode = "driving", units = "imperial")
      @params = {
        "origin"      => origin,
        "destination" => destination,
        "units"       => units,
        "mode"        => mode
      }
      @google_object = parse_response
      @error_msg = "Error!"
    end

    # Returns response
    def status
      @google_object["status"]
    end

    # Returns distance
    def distance
      @google_object["routes"][0]["legs"][0]["distance"]["text"] ||= @error_msg
    end

    # Returns duration
    def duration
      @google_object["routes"][0]["legs"][0]["duration"]["text"] ||= @error_msg
    end

    # Returns origin name
    def start_address
      @google_object["routes"][0]["legs"][0]["start_address"] ||= @params["origin"]
    end

    # Returns destination name
    def end_address
      @google_object["routes"][0]["legs"][0]["end_address"] ||= @params["destination"]
    end

    # Generates pretty JSON for command line output
    def full_response
      puts JSON.pretty_generate(@google_object)
    end

    def parse_response
      if fetch_response.kind_of? Net::HTTPSuccess
        JSON.parse(fetch_response.body)
      elsif !fetch_response
        JSON.parse('{"status" : "No internet connection!"}')
      else
        JSON.parse('{"status" : "Google API unaviable!"}')
      end
    end

    # Gets response from Google API or returns false if no Internet connection
    def fetch_response
      connection? ? Net::HTTP.get_response(build_uri) : false
    end

    # Checks the Internet connection
    def connection?
      begin
        TCPSocket.new 'google.com', 80
        return true
      rescue SocketError
        return false
      end
    end

    # Builds URI with parameters
    def build_uri
      url = "https://maps.googleapis.com/maps/api/directions/json"
      uri = URI(url)
      uri.query = ""
      @params.each {|k, v| uri.query << "#{k}=#{v}&" }
      uri.query = uri.query.chop
      return uri
    end

    # Converts non english characters into english equivalents
    # Replaces spaces with "+"
    def convert_input(string)
      ActiveSupport::Inflector.transliterate(string).strip().tr(" ", "+")
    end

  end
end
