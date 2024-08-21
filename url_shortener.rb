# URL Shortener in Ruby
#
# Key Features:
# - URL shortening and retrieval
# - Persistent storage via JSON
# - Command-line interface for user interaction
#
# Usage:
# Run the script and follow the prompts to add or retrieve URLs.
# The shortened URLs are automatically saved upon exiting.

require 'uri'
require 'json'

# URLShortener: A class to manage URL shortening and retrieval.
class URLShortener
  def initialize
    @url_map = load_url_map
  end

  # The main method to run the URL shortener program.
  def run
    loop do
      puts "1: Add a URL. 2: Retrieve a URL. 3: Exit. 4: Show all mappings."
      user_input = gets.chomp

      case user_input
      when "1"
        puts "Enter your URL:"
        url_to_shorten = gets.chomp
        unless validate_url(url_to_shorten)
          puts "Invalid URL"
          next
        end
        code = new_code(url_to_shorten)
        if code
          puts "#{code}: #{url_to_shorten}"
        else
          puts "URL is already shortened."
          puts "Here is the shortened URL: #{@url_map.key(url_to_shorten)}"
        end
      when "2"
        puts "Enter your shortened URL:"
        url = get_url(gets.chomp)
        puts url ? url : "No such shortened URL."
      when "3"
        save_url_map
        break
      when "4"
        show_mappings
      else
        puts "Unexpected input."
      end
    end
  end

  private

  # Load the url mappings from the JSON file.
  #
  # @return [Hash] The loaded url mappings.
  def load_url_map
    if File.file?("mapping.json")
      return JSON.parse(File.read("mapping.json"))
    else
      return {}
    end
  end

  # Save the currint mappings to mapping.json
  def save_url_map
    File.open('mapping.json', 'w') do |f|
      f.write(@url_map.to_json)
    end
  end

  # Displays all stored URL mappings.
  def show_mappings
    puts @url_map
  end

  # Check if a URL is valid.
  # @param url [String] The URL to validate.
  # @return [Boolean] True if the URL is valid, otherwise false.
  def validate_url(url)
    if url =~ URI::regexp
      return true
    end
    return false
  end

  # Generates a random string of 6 upercase letters to use be used as a unique short code.
  #
  # @return [String] A unique string with consisting of 6 capital letters.
  def random_code
    return (0...6).map { ('A'...'Z').to_a[rand(26)] }.join
  end

  # Generates a new unique code and updates @url_map. If the full URL is already in the URL map, it does not update @url_map.
  #
  # @param url_to_shorten [String] The URL to shorten.
  # @return [String, nil] A new unique code, or nil if the full URL is already in the URL map.
  def new_code(url_to_shorten)
    code = ""
    if @url_map.has_value?(url_to_shorten)
      return nil
    else
      while code == "" or @url_map.has_key?(code) do
        code = random_code
      end
      @url_map[code] = url_to_shorten
    end
    return code
  end

  # Retrieve the full URL corresponding to a code.
  # @param code [String] The shortened code.
  # @return [String, nil] The original URL or nil if the code does not exist.
  def get_url(code)
    if @url_map.has_key?(code)
      return @url_map[code]
    end
    return nil
  end

end

URLShortener.new.run
