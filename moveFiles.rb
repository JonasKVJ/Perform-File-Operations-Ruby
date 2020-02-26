# Author: Jonas Stagnaro
# For (unit) testing purposes only
# Moves a set of files, selected with regex, from a source folder to a destination folder

require 'fileutils'

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

#Move files from folder A to folder B, and if a regex pattern is specified, move only the files which match the pattern
def moveFiles(source=nil, destination=nil, regexPattern=nil)
  acceptedInput = ['y', 'yes', 'n', 'no']
  src, dst, rgx = source, destination, regexPattern
  input = ""

  begin
    #Ask for the path of folder A and B from the user
    while (!acceptedInput.include?(input))
      puts "Are the files in the same directory as this program? (y/n)"
      input = gets.chomp.downcase
    end

    if (input=='y' || input=='yes')
      src = Dir.pwd
      puts "Files will be moved from: #{src}"
    elsif (input=='n' || input=='no')
      while (input!='y' && input!='yes' && src==nil) #src received from function or stdin
        puts "Please specify the complete path of the folder containing the files to be deleted (the path will appear
when the folder is dragged into the Terminal app): "
        src = gets.chomp
        puts "Is this path correct? (y/n)"
        puts src
        input = gets.chomp.downcase
      end
    end

    begin
      if (dst != nil) then break end  #dst received from function or stdin
      puts "Please specify the path of the destination folder, which the files will be moved to: "
      dst = gets.chomp
      puts "Is this path correct? (y/n)"
      puts dst
      input = gets.chomp.downcase
    end while (input!='y' && input!='yes')
  end

  rgx = getRegexOptions()


  Dir.glob(src + "/*").each do |f| #Select and sort all files in the source folder
    filename = File.basename(f) #Gets each filename, including the file extension
    if (rgx==nil)
      FileUtils.mv(f, dst + "/" + filename)
    else
      if (filename =~ rgx) #If the filename matches the regex pattern
        FileUtils.mv(f, dst + "/" + filename)
      end
    end
  end
end


#Default source (from where to get the files) and destination (where to move the files to) folders, used if no path
# is provided
src = "/Set/your/default/source/folder"
dst = "/Set/your/default/destination/folder"
#regexPattern = /test/
moveFiles(src, dst)


