# Kojak - Exploring NYC's Moving Populations

![NYC](https://cloud.githubusercontent.com/assets/9892419/7870924/741a68ae-055a-11e5-8a93-8fe92c6068a9.png)

![Gentrification](https://cloud.githubusercontent.com/assets/9892419/7871223/79923dc8-055c-11e5-9061-4f439b613b7d.jpg)

Final project within the Metis Bootcamp. Given full control over the design, implementation and presentation of the data science project, I worked to identify early signals of gentrification in NYC by looking at people’s voluntary movements through the city. In other words, can you gleam insights into emerging destinations by looking at where people go for fun?

INSIGHT: I can look at MTA turnstile data during BRUNCH (Saturday & Sunday) and NIGHTLIFE (Friday & Saturday) for voluntary travel!!!

![BRUNCH](https://cloud.githubusercontent.com/assets/9892419/7871338/3fd2c69c-055d-11e5-8fdf-02c511a8f431.jpg)

![NIGHTLIFE](https://cloud.githubusercontent.com/assets/9892419/7871227/7b28d3f4-055c-11e5-9bc5-651696b4a807.jpg)

To accomplish the task, I harvested and combined data (MTA turnstile, Station Geocodes, Property Values, GeoJSONs, Inflation Adjuster) from a variety of sources (e.g., [web scraped urls, wget for page content](http://web.mta.info/developers/turnstile.html "MTA turnstile data"), [Github repositories](https://github.com/chriswhong/nycturnstiles "station geocodes"), [extracted data from D3 viz](http://youarehere.cc/#/maps/by-city/new_york "MIT Media Labs's YouAreHere Project"), [OpenNYC](https://nycopendata.socrata.com/ "Neightborhood Boundaries"), [Wolfram Alpha](https://www.wolframalpha.com/ "Wolfram Alpha")). [All original data uploaded in respective folders].

![Process](https://cloud.githubusercontent.com/assets/9892419/7870925/76466948-055a-11e5-945a-d22be3ab2b23.png)

Set up remote MySQL server on [Digital Ocean](https://www.digitalocean.com/ "Digital Ocean") allowing me to perform hours long SQL joins on the cloud while sleeping [SQL setup commands in SQL setup folder]. Mapped subway stations and property values to neighborhood polygons. Adjusted property values for inflation. Performed extensive data cleaning, filtering, and aggregation to create exploratory D3 interactive visualization [d3 folder contains html, images, and final jsons]. 

![Demo](https://github.com/JessicaFreaner/Kojak/blob/master/images/recording.gif?raw=true)

Easily consumable [presentation of project](http://www.slideshare.net/JessFreaner/gentrification-project-kojak "Slideshare") uploaded as PDF in Presentation Folder.

![ThisIsMetis](https://cloud.githubusercontent.com/assets/9892419/7356548/e1a3b3ac-ecf6-11e4-8fb6-be39f563742e.jpg) 
##Other Metis Projects:

[Benson](http://jessicafreaner.github.io/Benson/ "Exploring MTA Data") - Exploring MTA Data

[Luther](http://jessicafreaner.github.io/Luther/ "Exploring Movie Data") - Exploring Movie Data

[McNulty](http://jessicafreaner.github.io/McNulty/ "Exploring Heart Health Data") - Exploring Heart Health Data

[Fletcher](http://jessicafreaner.github.io/Fletcher/ "Exploring Data with NLP") - Exploring Data with NLP
