# -*- coding: utf-8 -*-
"""
Created on Wed Jun  5 10:04:57 2024

@author: echraibi
"""

import geopandas as gpd
import numpy as np
import seaborn as sns
import requests
import io,json 

import xml.etree.ElementTree as ET
import xml

def prettify(elem):
    """Return a pretty-printed XML string for the Element.
    """
    rough_string = ET.tostring(elem, 'utf-8')
    reparsed = xml.dom.minidom.parseString(rough_string)
    return reparsed.toprettyxml(indent="\t")

data = gpd.read_file("C:/Users/echraibi/Documents/projets/2024/frequentation/resultats/photos_coeur.gpkg")

res = np.array(np.unique(data.owner, return_counts=True)).T

tmpres = sorted(
    res, 
    key=lambda x: x[1]
)

tenbest = tmpres[-10:]


api_key = ""
api_s =  ''

endpoint = "https://api.flickr.com/services/rest/"

listres = []
for us in tenbest:
    usid = us[0]
    params = {
            "method": "flickr.people.getinfo",
            "api_key": api_key,
            #"text": "mercantour",
            "user_id": usid,
        }
    
    response =  requests.get(endpoint, params=params) 
    listres.append(response)
    
xmls = [ET.fromstring(stringe.text) for stringe in listres]

xml = xmls[-3]


for i,xml in enumerate(xmls):
    print(str(10-i))
    tmp = xml.findall('person')[0]
    for child in tmp:
        print(child.tag, child.attrib)

def element_to_string(element):
    s = element.text or ""
    for sub_element in element:
        s += ET.tostring(sub_element)
    s += element.tail
    return s



