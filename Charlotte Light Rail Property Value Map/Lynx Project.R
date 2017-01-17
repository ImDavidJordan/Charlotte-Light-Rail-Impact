library(leaflet,rgdal)

setwd("/Users/David_Jordan/Google Drive/Special Projects/CharlotteLightrail/Charlotte Light Rail Property Value Map/")

#Current and Extension Lightrail GeoSpatial Data
LightRailStation <- read.csv("Lynx Station Map.csv")
#Dataset Tracking Redevelopment Proposals Source: http://charlottenc.gov/planning/rezoning/pages/home.aspx

#Charlotte Census Data
Charlotte_Census <- read.csv("2010 Charlotte Census Data.csv")
#Zipcode Shapefile Dataset
Zipcode_Shape <- readOGR("Zipcode Shape Files/cb_2015_us_zcta510_500k.shp", layer="cb_2015_us_zcta510_500k")

#Subsetting the Lynx Line Stations
  #Original Stations
OrgStat<-subset(LightRailStation,LightRailStation$Category=="Lynx Blue Line Stop")
  #Extension Stations
BLESTAT <- subset(LightRailStation,LightRailStation$Category=="Lynx Blue Line Extension Stop")

#Subsetting the Zipcode_Shape dataset to only include Charlotte Zipcodes
Charlotte_Zips <- subset(Zipcode_Shape,Zipcode_Shape$ZCTA5CE10 %in% Charlotte_Census$Zip.Code)

#Creating Map Icons
train=makeIcon("Train.png","Train.png",18,18)
train_blue=makeIcon("Train_Blue.png","Train_Blue.png",18,18)
apartment=makeIcon("Apartments.png","Apartments.png",18,18)

#Constructing the R Leaflet Map
leaflet() %>%
  addProviderTiles("OpenStreetMap") %>%
  addMarkers(data=OrgStat, group="Blue Line Station", popup=OrgStat$Item, icon=train) %>%
  addMarkers(data=BLESTAT, group="Blue Line Extension Station", popup=BLESTAT$Item, icon=train_blue) %>%
  addPolygons(data=Charlotte_Zips, color="#fec44f", popup=paste("Household Income: ", Charlotte_Census$Avg..Income.H.hold, "<br>", "Population: ", Charlotte_Census$Population))
  

