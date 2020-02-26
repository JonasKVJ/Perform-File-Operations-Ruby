# Perform-File-Operations-Ruby
Selects a set of files with regex, and deletes, moves or renames the set. When moving files, specify a destination folder to move the files to. The user is not required to know any programming languages or regex to use fileOperations.rb - it is very user friendly. The emphasis of this program is on the scalability of it and the potential for it to be further developed to become part of some automated pipeline (but mostly just coding practice). 

## For advanced users:
All of the files can be slightly modified to run based on a provided absolute path in the program itself, as opposed to one provided as an input string. This is of course much more easily repeatable for testing purposes, especially involving the creation of several thousand text files with createFiles.rb.  

## Overview of files:
- createFiles.rb: Create a set of text files to run file operations on. Good for understanding how fileOperations.rb works.
- deleteFiles.rb: Delete a set of files selected according to whether their filenames matches a specified regex pattern
  - Used for unit testing purposes only
- fileOperations.rb: Complete standalone program, which deletes, moves or renames an entire set of files based on a regex pattern specified by the user. Also includes a short regex tutorial, so as to allow any anyone not knowing regex to use it.
- moveFiles.rb: Moves a set of files selected with regex, from a specified source folder to a specified destination folder.
- renameFiles: Renames a set of files selected with regex

## How to run (much easier on OSX):
1) (optional, OSX only) Install Homebrew
2) (optional, OSX only) Install rbenv, Ruby version manager
3) Install the latest Ruby, ideally with rbenv (not good to use inbuilt version if using OSX)
4) Open Terminal or the Windows equivalent, type `Ruby fileOperations.rb` and follow the instructions


