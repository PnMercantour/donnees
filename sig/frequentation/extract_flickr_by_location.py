# -*- coding: utf-8 -*-
"""
Created on Thu May 30 09:44:06 2024

@author: echraibi
https://javierladino.com/fr/portfolio/creer-une-empreinte-chromatique-a-partir-de-flickr-en-utilisant-python/
"""


### Get Bounding box
import os
import requests 
import pandas as pd
import geopandas as gpd
import numpy as np
import io,json 
import math
from pyproj import Transformer

from shapely.geometry import Point


api_key = ""
api_s =  ''

pd.set_option('display.float_format', lambda x: '%.3f' % x)

limites = gpd.read_file('C:/Users/echraibi/Documents/projets/2024/frequentation/data/extraction_scluos/allos.gpkg')

bbox = limites.buffer(500).bounds.values.flatten()
# tentative d'avoir la distance par la fonction distance
"""
points_df = gpd.GeoDataFrame({'geometry': 
                              [Point(bbox[0], bbox[2]), 
                               Point(bbox[0], bbox[2])]}, 
                             crs='EPSG:2154')
points_df_2 = gpd.GeoDataFrame({'geometry': 
                                  [Point(bbox[1], bbox[2]), 
                                   Point(bbox[0], bbox[3])]}, 
                                 crs='EPSG:2154')
points_df = points_df.to_crs('EPSG:2154')
points_df.distance(points_df_2)
"""
larg = abs(bbox[2] - bbox[0])
long = abs(bbox[3] - bbox[1])

blocs_larg = math.ceil(larg /5000)
blocs_long = math.ceil(long /5000)

transformer = Transformer.from_crs("EPSG:2154", "EPSG:4326")
a = transformer.transform(bbox[0], bbox[1])
b = transformer.transform(bbox[2], bbox[3])

# bounding box du coeur de parc
bbox = a+b


if blocs_larg>1 or blocs_long>1:
    ### Split bounding box
    xs = np.linspace(bbox[0], bbox[2], blocs_larg)
    ys = np.linspace(bbox[1], bbox[3], blocs_long)
    bboxs = []
    for i in range(len(xs)-1):
        for j in range(len(ys)-1):
            temp_bbox = [ ys[j], xs[i],  ys[j+1],xs[i+1]]
            bboxs.append([temp_bbox])
else: bboxs = [[bbox[1], bbox[0], bbox[3], bbox[2]]]
###
folder_res = "C:/Users/echraibi/Documents/projets/2024/frequentation/data/lac_allos/"
res = []
for j in range(len(bboxs)):
    
    
    # authion_min = (43.9921840568007, 7.411301766697626)
    # authion_max = (43.980813135192605, 7.391848688119345)
    
    endpoint = "https://api.flickr.com/services/rest/"
    
    params = {
            "method": "flickr.photos.search",
            "api_key": api_key,
            "bbox": (",".join(str(i) for i in bboxs[j])), #[1:-1],
            #"text": "mercantour",
            "sort": "relevance",
            "format": "json",
            "nojsoncallback": 1,
            "extras": "date_taken,geo,views",
            "per_page": 500
        }
    
    response =  requests.get(endpoint, params=params) 
    res = response.json()
    if res['photos']['pages']>1:
        params_b = params.copy()
        for k in range(res['photos']['pages']):
            params_b['page'] = k+1
            response =  requests.get(endpoint, params=params_b) 
            res = response.json()
            outfile = folder_res + f'{j}_{k+1}.json'
            # res.append(response.json())
            # write to file
            with io.open(outfile, 'w+', encoding='utf-8') as f:
                json.dump(res, f, indent=4)

    else:
        outfile = folder_res+ f'{j}.json'
        # res.append(response.json())
        # write to file
        with io.open(outfile, 'w+', encoding='utf-8') as f:
            json.dump(response.json(), f, indent=4)
    
    
### Get the other PAGES!    
    
### Write to file
"""
json_object = json.dumps(res[0], indent = 4)
with io.open('C:/Users/echraibi/Documents/projets/2024/frequentation/data/test.json', 'w+', encoding='utf-8') as f:
    json.dump(res[0], f, indent=4)
"""

"""
import flickr_api
flickr_api.set_keys(api_key = 'bdfc6fdfcc6241ce7349f1b46a3074df', 
                    api_secret = '99204037b1d93b8e')

user = flickr_api.Person.findByUserName("ErGoC")
photos = user.getPhotos()



"""

