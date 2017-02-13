module DistanceFinder
  class Calculator

    attr_reader :distance, :duration, :start_address, :end_address, :display_full_response

    def initialize(origin, destination)
      @origin = origin.strip().tr(" ", "+")
      @destination = destination.strip().tr(" ", "+")
      @google_object = parse_response
    end

    # Return distance
    def distance
      @google_object["routes"][0]["legs"][0]["distance"]["text"]
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
      JSON.parse(get_response)
    end

    def get_response
      Net::HTTP.get(URI(build_url))
    end

    def build_url
      "https://maps.googleapis.com/maps/api/directions/json?origin=#{@origin}&destination=#{@destination}"
    end

  end
end
