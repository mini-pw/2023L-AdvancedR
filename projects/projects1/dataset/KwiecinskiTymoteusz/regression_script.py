# -*- coding: utf-8 -*-
"""
Created on Tue Mar  7 21:11:21 2023

@author: tymot
"""

import requests
import json
import pandas as pd
import time
import numpy as np


# Instantiate a dictionary of headers
# We only need to `manipulate` an User-Agent key
headers = {
    "User-Agent": "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0",
}

# Instantiate a dictionary of query strings
# Defines the only needed payload
payload = {
        "currency_code": "EUR",
        "grape_filter": "varietal",
        "min_rating": "1",
        "order_by": "price",
        "order": "asc",
        "page": 1,
        "price_range_max": "500",
        "price_range_min": "0",
        "wine_type_ids[]": "1",
}

# Performs an initial request and gathers the amount of results
r = requests.get('https://www.vivino.com/api/explore/explore?',
                 params=payload, headers=headers)
n_matches = r.json()['explore_vintage']['records_matched']

res = r.json()['explore_vintage']


# Create Dataframe
column_names=["Winery", "Year", "Wine ID", "Wine", "Rating", "num_review", "price", 'Country', 'Region', 
              'acidity', 'calculated_structure_count', 'intensity', 'sweetness', 'tannin',
              'user_structure_count', "vintage_type", "has_valid_ratings", "is_natural"]
df = pd.DataFrame(columns = column_names)

# Iterates through the amount of possible pages
# A page is defined by n_matches divided by 25 (number of results per page)
for i in range(int(n_matches / 25)+1):
    # Adds the page on the payload
    payload['page'] = i + 1

    print(f'Requesting data from page: {payload["page"]}')

    # Performs the request and saves the matches
    r = requests.get('https://www.vivino.com/api/explore/explore?',
                 params=payload, headers=headers)
    # matches = r.json()['explore_vintage']['matches']
    results = []
    
    for t in r.json()["explore_vintage"]["matches"] :
        region = t['vintage']['wine']['region']
        structure = t['vintage']['wine']['taste']['structure']
    
        obs = (
            t["vintage"]["wine"]["winery"]["name"],
            t["vintage"]["year"],
            t["vintage"]["wine"]["id"],
            f'{t["vintage"]["wine"]["name"]} {t["vintage"]["year"]}',
            t["vintage"]["statistics"]["ratings_average"],
            t["vintage"]["statistics"]["ratings_count"],
            t["prices"][0]["amount"],
            None if region is None else region['country']['name'],
            None if region is None else region['name'],
            None if structure is None else structure['acidity'],
            None if structure is None else structure['calculated_structure_count'],
            None if structure is None else structure['intensity'],
            None if structure is None else structure['sweetness'],
            None if structure is None else structure['tannin'],
            None if structure is None else structure['user_structure_count'],
            t["vintage"]["wine"]["vintage_type"],
            t["vintage"]["wine"]["has_valid_ratings"],
            t["vintage"]["wine"]["is_natural"]
        )
        
        results += [obs]
        
    df2 = pd.DataFrame(results, columns=column_names)
    df = df.append(df2)
    

df.to_csv("regression.csv", index=False)


#df = pd.read_csv("regression.csv")


