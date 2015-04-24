# Kojak - Exploring NYC's Moving Populations

Final project within the Metis Bootcamp. Given full control over the design, implementation and presentation of the data science project, I worked to identify early signals of gentrification in NYC by looking at people’s voluntary movements through the city. In other words, can you gleam insights into emerging destinations by looking at where people go for fun?

INSIGHT: I can look at MTA turnstile data during BRUNCH (Saturday & Sunday) and NIGHTLIFE (Friday & Saturday) for voluntary travel!!!

TO accomplish the task, I harvested and combined data (MTA turnstile, Station Geocodes, Property Values, GeoJSONs, Inflation Adjuster) from a variety of sources (e.g., [web scraped urls, wget for page content](http://web.mta.info/developers/turnstile.html "MTA turnstile data"), [Github repositories](https://github.com/chriswhong/nycturnstiles "station geocodes"), [extracted data from D3 viz](http://youarehere.cc/#/maps/by-city/new_york "MIT Media Labs's YouAreHere Project"), [OpenNYC](https://nycopendata.socrata.com/ "Neightborhood Boundaries"), [Wolfram Alpha](https://www.wolframalpha.com/ "Wolfram Alpha")). [All original data uploaded in respective folders].

Set up remote MySQL server on (Digital Ocean)[https://www.digitalocean.com/] allowing me to perform hours long SQL joins on the cloud while sleeping [SQL setup commands in SQL setup folder]. Mapped subway stations and property values to neighborhood polygons. Adjusted property values for inflation. Performed extensive data cleaning, filtering, and aggregation to create exploratory D3 interactive visualization [d3 folder contains html, images, and final jsons]. 

Easily consumable presentation of project uploaded as PDF in Presentation Folder.
