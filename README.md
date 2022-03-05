# site-update-notify
## (ALPHA version)
A simple bash script for checking if a static site was updated.

## Usage
Using the script is a simple as running the script file:
```bash
$ ./script.sh
```
The script will first download the html files in a specified folder (see Installation and Customizing) and compared them with the already downloaded ones. If that is the first time a html file was download it, it will store that version without further notifications. If there was no changes to the site, the temporary htmls will be deleted and the script continues to the next link. If there was some change in the html, the script will grab the urls using **curl** and will launch **notify-send** and **paplay** to display the appropriate notification on your desktop.

## Installation and Customizing

### Running the installer
*The installer is currently in its early alpha version*.


### Manual Installation
#### Requirements
The script requires [curl](https://curl.se/), [notify-send](https://ss64.com/bash/notify-send.html) and [paplay](https://linux.die.net/man/1/)  to run. You need to install the packages manually for the script to run properly.
Other than the packages, the script requires a directory tree where the site entries and temporary html files will be stored and a txt from where the script will read the urls.

#### Customizing the directory tree
The current default is entries and is located in the same folder as the script. To specify where the entries and tmp files will be stored, open the script and change the *$DIR* variable:
```bash
8                                                                                 
9 #Directory where the entry versions will be stored                              
10 dir="path/to/dir"                                                                   
11   
```
#### Grabber file
The script grabs the urls from a file, whose default name is *.sites-to-grab.txt* and is stored in the same location as the . To change this, open the script and change the *$FILE_URL* variable.
```bash
1 #!/bin/bash                                                                     
2                                                                                 
3                                                                                 
4                                                                                 
5                                                                                 
6 #File path of the file where the site urls are stored                            
7 FILE_URL="path/to/file"
8                                                                          
```
Every line in the file must be a valid url to a static site (**WARNING**: storing a url to a dynamic site will not work)

## Contact
For any questions, bugs and other topics, you can send an issue on the repo:https://github.com/stojkovic-mihailo/site-update-notify , or contact me by mail: mihailo.stojkovic1@gmail.com
