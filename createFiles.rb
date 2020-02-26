# Author: Jonas Stagnaro
# For testing purposes only
# Specify the folder which you want files to be created in
# Available file operations: Delete, move or rename
# Run fileOperations.rb to perform all of these operations on any set of files (not just ones created with this program)
src = "/The/folder/where/text/files/will/be/created"

#Recursive creation (for possible future reference only):
#Dir.glob("**/*/") # for directories
#Dir.glob("**/*") # for all files

#.txt format because it is easy to work with
def createFiles(src, amount)
  i = 1
  while i<amount do
    #Create
    File.open(src + "/test" + i.to_s + ".txt", "a+") {|f| f.write("Placeholder text")}
    #puts "Created test#{i}.txt"
    i += 1
  end
end

createFiles(src, 10)