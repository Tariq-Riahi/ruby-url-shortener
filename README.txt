# URL Shortener in Ruby

## Overview
This project is a simple URL Shortener implemented in Ruby without any external frameworks. It allows users to shorten URLs into a 6-character string and retrieve the original URL using the shortened version. The program stores URL mappings in a JSON file (`mapping.json`) to maintain persistence between sessions.

## Features
- **Shorten URLs:** Input a full URL and receive a 6-character shortened version.
- **Retrieve URLs:** Input a shortened URL to retrieve the original full URL.
- **Persistent Storage:** URL mappings are saved in a JSON file for use across sessions.
- **View All Mappings:** Option to display all shortened URLs and their corresponding full URLs.

## Usage
1. **Add a URL:**
   - Select option `1` to input a URL and receive a shortened version.
   - If the URL is already shortened, the program will return the existing short code.

2. **Retrieve a URL:**
   - Select option `2` to input a shortened URL code and retrieve the original full URL.

3. **View All Mappings:**
   - Select option `4` to view all current URL mappings stored in the system.

4. **Exit:**
   - Select option `3` to save all mappings and exit the program.

## How to Run
- Ensure you have Ruby installed on your machine.
- Place the code in a file named `url_shortener.rb`.
- Run the script using the command:
