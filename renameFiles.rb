# Author: Jonas Stagnaro
# For (unit) testing purposes only
# Renames a set of files selected with regex

#!/usr/bin/env ruby

#Unit test with a focus on renaming files
require 'fileutils' #File methods
require 'pathname' #Pathname methods

#t1 = Time.now


def getRegexOptions
  begin
    puts "Would you like to specify an optional regex pattern?"
    puts "1) Yes"
    puts "2) No"
    puts "3) Please show me a 5-minute getting started regex tutorial"
    input = gets.to_i
    if (input==1)
      begin
        puts "Please specify a regex pattern: "
        regexWithSlashes = gets.chomp

        #Delete all slashes, because Regexp.new() does not expect them
        regexWithoutSlashes = regexWithSlashes.gsub(/\//, '')
        regex = Regexp.new(regexWithoutSlashes) #Use Regexp.new() to convert from String to Regexp
        puts "Is this correct? (y/n)"
        puts regex.inspect
        input2 = gets.chomp.downcase
      end while (input2!='y' && input2!='yes')
    end
    if (input == 2)
      begin
        puts "Warning: If no regex pattern is specified, all files in the specified folder will be affected.
Is this okay? (y/n)"
        input2 = gets.chomp.downcase
        if (input2=='n' || input2=='no')
          input = -1 #If the user changes their mind and decides to specify a regex pattern, despite saying no initially
          break
        end
      end while (input2!='y' && input2!='yes')
    end
    if (input==3)
      showTutorial()
    end
  end while (input!=1 && input!=2)

  return regex
end


def showTutorial
  puts "---------------------------------------------------------------------------------------------------------------"
  puts "\nThink of regex as a means to select only certain files which share a specified text pattern in their name. The
  following are some cases that would probably be seen fairly often: \n\n"
  puts "--Example 1: Selecting files with a certain file extension--"
  puts "A regex expression that selects all Word files would be written as \n/.doc/\n, where a regex expressions begins
and ends with a forward slash.\n\n"
  puts "--Example 2: When filenames involve numbers--"
  puts "If you happen to have 500 .png files, but only want to rename/move 71 of them, \n/[149-220]/\n would select the
files with numbers (inclusively) in between 149 and 220 in their name.\n\n"
  puts "--Example 3: Looking for specific patterns--"
  puts "In a similar way to the previous two examples, any specific pattern can be designated; so if one happens to have
130 files with _bird_and_cat_2017 in their name, \n/_bird_and_cat_2017/\n would select only those files.\n\n"
  puts "End of tutorial"
  puts "For a more comprehensive regex beginner's tutorial, visit 'Ruby - Regular Expressions' at tutorialspoint.com"
  puts "---------------------------------------------------------------------------------------------------------------"
end


#Rename a set of files found in the src directory, and if an optional regex pattern is specified, rename only
#the files with a filename that matches the pattern
def renameFiles(source = nil, regexPattern = nil)
  acceptedInput = ['y', 'yes', 'n', 'no']
  src, rgx = source, regexPattern

  #Get the path of the folder containing the files to be deleted
  begin
    if(src != nil) then break end #src can be supplied through the function or stdin
    puts "Are the files to be renamed in the same directory as this program? (y/n)"
    input = gets.chomp.downcase
  end while (!acceptedInput.include?(input))

  if (input=='y' || input=='yes')
    src = Dir.pwd
    puts "Files will be deleted from: #{src}"
  elsif (input=='n' || input=='no')
    while (input!='y' && input!='yes')
      puts "Please specify the complete path of the folder containing the files to be deleted (the path will appear
when the folder is dragged into the Terminal app): "
      src = gets.chomp
      puts "Is this path correct? (y/n)"
      puts src
      input = gets.chomp.downcase
    end
  end


  begin
    puts "Which kind of renaming would you like to do?"
    puts "1) Rename files according to a system (for example cat1, cat2, ...)"
    puts "2) For each file, replace part of the filename with something else"
    caseNumber = gets.chomp.to_i
  end while (caseNumber!=1 && caseNumber!=2)

  #Get an optional regex pattern
  rgx = getRegexOptions()

  count = 0
  #1) Rename files according to a system
  if (caseNumber == 1)
    number = 1

    #Get the new systematic name - i.e. 'cat' if the naming system is cat1, cat2, ..., catN
    puts "Please specify your systematic name - i.e.'cat' if the naming system is cat1, cat2, ..., catN: "
    systematicName = gets.chomp

    Dir.glob(src + "/*").each do |f| #Select and sort all files in the source folder
      filename = File.basename(f, File.extname(f)) #Gets each filename, without file extension
      newPathname = src + "/" + systematicName + number.to_s + File.extname(f)

      #Check whether a file with the new name already exists - if yes, skip current rename iteration
      pn = Pathname.new(newPathname)
      if (pn.exist?())
        puts "#{f} could not be renamed, because #{File.basename(newPathname)} already exists"
        number += 1 #If cat[number] exists, move on to the next number
        next
      end

      if (rgx == nil)
        #Catch the SystemCallError, in case a file can not be renamed due to platform-dependent errors
        begin
          File.rename(f, newPathname)
        rescue SystemCallError
          puts "Caught SystemCallError!\n Something went wrong, exiting program..."
          exit(false) #EXIT_FAILURE, same as exit(1)
        end
        count += 1
        number += 1
      elsif (rgx != nil)
        if (filename =~ rgx)
          begin
            File.rename(f, newPathname)
          rescue SystemCallError
            puts "Caught SystemCallError!\n Something went wrong, exiting program..."
            exit(false) #EXIT_FAILURE, same as exit(1)
          end
          count += 1
          number += 1
          #puts "Renamed #{filename} to #{newPathname}"
        end
      end

      if (rgx == nil) #Debugging
        #puts "Renamed #{filename} to #{newPathname}"
      end
    end

    #2) For each file, replace part of the filename with something else
  elsif (caseNumber==2)
    puts "Please specify the text of the filenames that should be replaced: "
    oldSubstring = gets.chomp
    puts "Please specify what the previous text should be replaced with: "
    newSubstring = gets.chomp


    if (rgx == nil)
      #Confirm the details of the renaming
      begin
        puts "For each file located in #{src}, every occurance of #{oldSubstring} in each filename will be replaced with
#{newSubstring}. Is this correct? (y/n)"
        input = gets.chomp.downcase
        if (input=='n' || input=='no')
          puts "Please start over, restarting program..."
          exit(false) #EXIT_FAILURE, same as exit(1)
        end
      end while (input!='y' && input!='yes')

      Dir.glob(src + "/*").each do |f| #Apply case 2) to all files in the source folder
        filename = File.basename(f, File.extname(f)) #Gets each filename, without file extension

        #The new filename is created by replacing all instances of oldSubstring with newSubstring by using Regex
        #(Regex is used here because it appears to be faster than simply specifying the plain oldSubstring)
        newFileName = filename.gsub(Regexp.new(oldSubstring), newSubstring)
        newPathname = src + "/" + newFileName + File.extname(f)

        if (f == newPathname) #This happens when oldSubstring is not present in the current filename
          next
        end

        #Check whether a file with the new name already exists - if yes, skip current rename iteration
        pn = Pathname.new(newPathname)
        if (pn.exist?())
          puts "#{f} could not be renamed, because a file with that name already exists"
          next
        end

        #Catch the SystemCallError, in case a file can not be renamed due to platform-dependent errors
        begin
          File.rename(f, newPathname)
        rescue SystemCallError
          puts "Caught SystemCallError!\n Something went wrong, exiting program..."
          exit(false) #EXIT_FAILURE, same as exit(1)
        end
        count += 1
      end


    elsif (rgx != nil)
      Dir.glob(src + "/*").each do |f| #Apply case 2) to regex-matching files only
        filename = File.basename(f, File.extname(f)) #Gets each filename, without file extension
        #The new filename is created by replacing all instances of oldSubstring with newSubstring by using Regex
        #(Regex is used here because it appears to be faster than simply specifying the plain oldSubstring)
        newFileName = filename.gsub(Regexp.new(oldSubstring), newSubstring)
        newPathname = src + "/" + newFileName + File.extname(f)
        if (f == newPathname) #This happens when oldSubstring is not present in the current filename
          next
        end

        if (filename =~ rgx)
          #Check whether a file with the new name already exists - if yes, skip current rename iteration
          pn = Pathname.new(newPathname)
          if (pn.exist?())
            puts "#{f} could not be renamed, because a file with that name already exists"
            next
          end

          begin
            File.rename(f, newPathname)
          rescue SystemCallError
            puts "Caught SystemCallError!\n Something went wrong, exiting program..."
            exit(false) #EXIT_FAILURE, same as exit(1)
          end
          count += 1
          #puts "Renamed #{filename} to #{newPathname}"
        end
      end
    end
  end

  puts "Renamed #{count} files"
end

src = "/Users/jonasvinterjensen/Documents/Ruby/Test-1" #The folder where file operations will be performed
renameFiles(src)

#t2 = Time.now
#puts "The program took: #{t2-t1} seconds to finish"

