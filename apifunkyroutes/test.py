from bs4 import BeautifulSoup
import requests

# Define the URL of the Niceguys Pizza homepage
homepage_url = "https://niceguyspizza.com/"

# Send an HTTP GET request to the homepage URL
response = requests.get(homepage_url)

# Parse the HTML content using BeautifulSoup
soup = BeautifulSoup(response.content, "html.parser")

# Find the specials section
specials = soup.find("section", class_="specials")

# Extract the special event details
special_event_details = specials.find_all("p", class_="event-detail")

# Loop through the special event details and print them
for detail in special_event_details:
 print(detail.text.strip())