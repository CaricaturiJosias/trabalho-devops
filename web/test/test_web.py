
import requests

url = "http://localhost:8200/"

# Sending the GET request
response = requests.get(url)
# Checking the response status
if response.status_code == 200:
    print("Service working successfully")
else:
    raise Exception(f"Service is not working as expected: error code {response.status_code}")