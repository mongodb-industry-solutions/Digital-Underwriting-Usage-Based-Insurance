import pymongo
import random
from datetime import datetime, timedelta
import time
import sys
from dotenv import load_dotenv
import os


load_dotenv()

# Function to generate random customer IDs
def generate_id():
    name_list = ['Ondra', 'Ghisolfi', 'Schubert', 'Narasaki', 'Megos', 'Raboutou']
    return random.choice(name_list)

# Connect to MongoDB
client = pymongo.MongoClient(os.getenv("MONGO_DB_CONNECTION_STRING")
)
db = client["demo_UBI"]
collection = db["customerTripRaw"]

# Define the number of steps
num_steps = 1000

# Generate and insert documents in a loop
# Function to print a progress bar
def print_progress_bar(iteration, total, prefix='', suffix='', decimals=1, length=100, fill='█'):
    percent = ("{0:." + str(decimals) + "f}").format(100 * (iteration / float(total)))
    filled_length = int(length * iteration // total)
    bar = fill * filled_length + '-' * (length - filled_length)
    sys.stdout.write('\r%s |%s| %s%% %s' % (prefix, bar, percent, suffix))
    sys.stdout.flush()

timestamp = datetime.now()

for i in range(num_steps):
    
    document = {
        "timestamp": timestamp,
        "metadata": {
            "type": "distance",
            "vehicleId": ''.join(random.choices('abcdefghijklmnopqrstuvwxyz', k=5)),
            "milesDriven": round(random.uniform(0, 10), 4)
        },
        "customerId": generate_id(),
        "maxSpeed": round(random.uniform(0, 45), 2)  # Fixed rounding to 2 decimal places
    }
    collection.insert_one(document)
    timestamp += timedelta(hours=4)
    print_progress_bar(i + 1, num_steps, prefix='Progress:', suffix='Complete', length=50)
    time.sleep(0.5)