# -*- coding: utf-8 -*-
"""
Created on Thu May 30 23:08:20 2024

@author: echraibi
"""

import json
import os
import pathlib
import pandas as pd
import geopandas as gpd
import numpy as np
import matplotlib.pyplot as plt # for data visualization
# folder = "C:/Users/echraibi/Documents/projets/2024/frequentation/data/extraction_coeur"
folder = "C:/Users/echraibi/Documents/projets/2024/frequentation/data/lac_allos"

for i, file in enumerate(os.listdir(folder)):
    if file.endswith('json'):
        with open(pathlib.Path(os.path.join(folder, file))) as f:
            temp = json.load(f)
            
            df = pd.DataFrame.from_dict(temp["photos"]["photo"])
        if i==0:
            res=df.copy()
        else: 
            res = pd.concat((res,df))


gdf = gpd.GeoDataFrame(res, geometry=gpd.points_from_xy(res.longitude, res.latitude), 
                       crs="EPSG:4326")

resfr = gdf.to_crs(crs="EPSG:2154")
resfr.to_file("C:/Users/echraibi/Documents/projets/2024/frequentation/resultats/lac_allos.gpkg")


## Analyze
data = gpd.read_file("C:/Users/echraibi/Documents/projets/2024/frequentation/resultats/photos_coeur.gpkg")


resfolder = "C:/Users/echraibi/Documents/projets/2024/frequentation/exports"



# Params for export
tofile = True
"""
# ------------ Begin Plots
flickr = "#2D5CD9"

import seaborn as sns
# sns.set_style("whitegrid")

sns.set_theme(style="darkgrid", rc={'figure.figsize':(7,6)})
data.datetaken = pd.to_datetime(data.datetaken)
data['month'] = data.datetaken.dt.month
sns.histplot(data=data, x="month", color=flickr, shrink=1.4)
arr = np.array([1,2,3,4,5,6,7,8,9,10,11,12])
plt.xticks(arr)
plt.ylabel("Nombre")
plt.xlabel("Mois")
if tofile:
    plt.savefig(resfolder+"/mois.png", bbox_inches='tight')
    plt.clf()
else:
    plt.show()
    plt.clf()

sns.set_theme(style="darkgrid", rc={'figure.figsize':(7,6)})
data['hour'] = pd.Categorical(data.datetaken.dt.hour, np.arange(24).tolist())
ax = sns.histplot(data=data, x="hour", shrink=0.5, color=flickr)
arr = np.arange(24)
plt.xticks(arr)
plt.ylabel("Nombre")
plt.xlabel("Heure")
# mids = [rect.get_x() + rect.get_width() /2 for rect in ax.patches]
# ax.set_xticks(mids)
# ax.set_xticklabels(np.unique(data["hour"]))
if tofile:
    plt.savefig(resfolder+"/heure.png", bbox_inches='tight')
    plt.clf()

else:
    plt.show()
    plt.clf()


sns.set_theme(style="darkgrid", rc={'figure.figsize':(7,6)})
dictdays= {"Monday":"Lundi","Tuesday":"Mardi","Wednesday":"Mercredi",
           "Thursday":"Jeudi","Friday":"Vendredi","Saturday":"Samedi",
           "Sunday":"Dimanche"}

data['day'] = data.datetaken.dt.day_name()
data['jour'] = data.day.apply(lambda x : dictdays[x])
data['jour'] = pd.Categorical(data['jour'], 
                              ["Lundi", "Mardi", "Mercredi",
                               "Jeudi", "Vendredi", "Samedi",
                                         "Dimanche"])
fig = sns.histplot(data=data, x="jour", shrink=0.4, color=flickr)
# fig.xaxis.set_ticklabels = [dictdays[b.get_text()] for b in fig.xaxis.get_ticklabels()]

plt.ylabel("Nombre")
plt.xlabel("Jour")
if tofile:
    plt.savefig(resfolder+"/jour.png", bbox_inches='tight')
    plt.clf()
else:
    plt.show()
    plt.clf()


from matplotlib.ticker import MultipleLocator

sns.set_theme(style="darkgrid", rc={'figure.figsize':(7,6)})
plt.rcParams.update({"xtick.bottom" : True, "ytick.left" : False})
data['year'] = pd.Categorical(data.datetaken.dt.year, np.arange(1980,2024,1).tolist())

hist = sns.histplot(data=data, x="year", shrink=0.7, color=flickr)
# plt.xticks(sorted(np.unique(data['year'])))
# plt.xticks([x if x%5==0 else '' for x in np.arange(2000,2024) ])

ax = hist.axes
ax.minorticks_on()
ax.xaxis.set_minor_locator(MultipleLocator(1))
ax.xaxis.set_tick_params(which='minor', width=0.7, length=2.5)
# ax.tick_params(axis='x', which='minor', bottom=True)


plt.xlim(2000,2024)
plt.ylabel("Nombre")
plt.xlabel("Année")
if tofile:
    plt.savefig(resfolder+"/annee.png", bbox_inches='tight')
    plt.clf()
    
else: 
    plt.show()
    plt.clf()
"""


