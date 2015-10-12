# Ahonyabid Scraper
A simple web scraping command line app that fetches data from [Ahonyabid](http://www.ahonyabid.com) and manipulate it.
It also contains some utility functions such as converting Ahonyabid bid value to GHS.

## Installation
The app will run on any computer that has [Erlang](http://www/erlang.org) installed.
Just clone this repository and you're good to go.

## Usage
Navigate to the project folder and run

```# => ./ahonyabid_scraper``` on the command line

This will run the app and give you an output like this:
```
market | product              | sold_at | winner          
-------+----------------------+---------+-----------------
145.0  | Easy Power 10000m... | 1021.5  | lily_p          
400.0  | Itel iNote Prime     | 705.5   | odasani         
400.0  | Infinix Hot 2 X51... | 2943.0  | epsion          
200.0  | LCD Power Station... | 286.0   | Grey            
200.0  | Surfline Mi-Fi       | 823.0   | booggie         
400.0  | Itel iNote Prime     | 1982.5  | y2k             
200.0  | Capdase Portable ... | 899.0   | leafde          
750.0  | Infinix Zero 2 X5... | 2.0     | Grey            
200.0  | Surfline Mi-Fi       | 657.5   | ghandy          
200.0  | LCD Power Station... | 586.0   | bewise          
150.0  | Binatone BLG-402 ... | 1013.0  | johnson_mag     
200.0  | Surfline Mi-Fi       | 1376.5  | leafde          
400.0  | Itel iNote Prime     | 774.5   | babsie          
800.0  | Samsung ME86V 23 ... | 22.0    | amg             
900.0  | LG G3 Stylus         | 2275.0  | pandorra   
...

```

You can also load the app into your IEX session
