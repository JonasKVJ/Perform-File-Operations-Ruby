# Perform-File-Operations-Ruby (Independent Project)
Selects a set of files with filenames that match a specified regex pattern, and deletes, moves or renames the set. When moving files, is is necessary to specify a destination folder to move the files to. The user is not required to know any programming languages or regex to use fileOperations.rb - it is very user friendly. The emphasis of this program is on the scalability of it and the potential for it to be further developed to become part of some automated pipeline (but mostly just coding practice). 

## For advanced users:
All of the .rb files can be slightly modified to run based on a provided absolute path set in the program itself, as opposed to the path provided as input. This is of course much more easily repeatable for testing purposes, such as performing file operations on several thousands of text files created with createFiles.rb.  

## Overview of files:
- createFiles.rb: Create a set of text files to run file operations on. Good for understanding how fileOperations.rb works.
- deleteFiles.rb: Delete a set of files selected according to whether their filenames matches a specified regex pattern
- fileOperations.rb: Complete standalone program, which deletes, moves or renames an entire set of files based on a regex pattern specified by the user. Also includes a short regex tutorial, so as to allow anyone not knowing regex to use it.
- moveFiles.rb: Moves a set of files selected with regex, from a specified source folder to a specified destination folder.
- renameFiles: Renames a set of files selected with regex

## How to run (very easy if using OSX):
1) (Recommended, OSX only, High Sierra or later) Install Homebrew
2) (Recommended, OSX only) Install rbenv, Ruby version manager
3) Install a desired version of Ruby, ideally with rbenv
   - Ruby 2.5.3 is able to run the program
4) Open Terminal or the Windows/Linux equivalent, type `Ruby fileOperations.rb` and follow the instructions


