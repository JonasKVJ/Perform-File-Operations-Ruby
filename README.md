# Perform-File-Operations-Ruby (Independent Project)
Selects a set of files with filenames that match a specified regex pattern, and deletes, moves or renames the set. When moving files, it is necessary to specify a destination folder to move the files to. The user is not required to know any programming languages or regex to use fileOperations.rb - it is very user-friendly and even has an in-built tutorial. The emphasis of this program is on scalability and the potential for it to be further developed to become part of some automated pipeline (but mostly just coding practice). 

## For advanced users:
All of the .rb files can be slightly modified to run based on a provided absolute path set in the program itself, as opposed to the path user-provided to the Terminal. Setting the path in the program itself has the advantage of making test cases easier to repeat. An example would be to rename several thousand text files created with createFiles.rb.  

## Overview of files:
- createFiles.rb: Create a set of text files to run file operations on. Good for understanding how fileOperations.rb works.
- fileOperations.rb: Complete standalone program, which deletes, moves or renames an entire set of files based on a regex pattern specified by the user. Also includes a short regex tutorial, so as to allow anyone not knowing regex to use it.

## How to run (very easy if using OSX):
1) (Recommended, OS X only, High Sierra or later) Install Homebrew
2) (Recommended, OS X only) Install rbenv, Ruby version manager
3) Install a desired version of Ruby, ideally with rbenv
   - Ruby 2.5.3 has been verified to work on macOS High Sierra   
4) (Optional, advanced users) Create up to thousands of .txt files with createFiles.rb, if you do not currently have a large set of files requiring to be deleted, moved or renamed.
   - First, type `cd <directory where createFiles.rb is residing>`
   - Open the createFiles.rb with a text editor, and fill out `src = "/The/folder/where/text/files/will/be/created"` with the desired path where .txt files can be created. Warning: Creating more than a thousand text files could freeze up the system. 
   - Edit where it says `createFiles(src, 10)` and replace 10 with the desired number of text files to be created. 
   - Lastly, run the program with `Ruby createFiles.rb`
5) Open Terminal or the Windows/Linux equivalent, type `cd <replace this with the path to the folder that contains fileOperations.rb>` and type `Ruby fileOperations.rb`; then simply follow the instructions.


