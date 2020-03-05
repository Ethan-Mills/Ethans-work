install.packages("jsonlite")
install.packages("ggplot2")
library(jsonlite)
## The nice thing about github and using Project folders is that it allows people fron different sites to reproduce code. 

#The line below is no good to me because I do not have your harddrive. 
Json_url <- "c:/users/ethan/OneDrive/Documents/GitHub/dmjn328/Spotify end folder/Jsonfiles/StreamingHistory0."

#But I don't need it because I have your json files right here in my hard drive. So I can just use the file name. 
artistName <- fromJSON('StreamingHistory0.json')


## It seems to me to be working just fine.

summary(artistName)

#You have a variable endTime
#artistName
#trackName
#msPlayed (which I don't know what that is. )

## I would not call your R object artistName as you are importing data that is more than the artistName, you are importing, artist name, track name, and date and time played. 

# I would import each file in like this. 

files1<-fromJSON('StreamingHistory0.json')
files2<-fromJSON('StreamingHistory1.json')

### and so on and so on.

#Then, I would check to make sure that all your data frames have the same variables named. 
names(files1)

#If they do (and I suspect they do ), you can smush them together by using the bind_rows command in the tidyverse() package. 

## You can do a ton of interesting stuff with this. 

## 1. Find a way to count your most popular artists and tracks. (hint: use the group_by, summarize and n() functions. )
## 2. Find out when you most often listen to music. Look at the lubridate package functions. There are functions to extract the day, minute, hour aspects of a date variable. 

#currently your endTime is not a date variable.

str(files1)

## Convert it to a date variable using some of the functions in the lubridate package 
## You can turn it into a date variable with one command. https://lubridate.tidyverse.org/ And see the working with dates section. 

## You can also get the hour of each track listened to with one other command. 
# Then you could do a group_by(hour), summarize and n() commands and count how many tracks are in each hour. That would give you a picture of your daily listening habits by hour. 

