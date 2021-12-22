
# opening and reading the file 
file_var = "D:/Onedrive\OneDrive - Hogeschool West-Vlaanderen/21-22 derde/Network Scripting/NetworkScriptingXanderPetit/Examen/Voor deel 3/LVL-2-POE-config.txt"

text = "hostname"

def find_string(file_var, text):
    file_var = open(file_var, "r")
    lines = file_var.readlines()
    
    new_list = []
    idx = 0


        # looping through each line in the file
    for line in lines:
            
            # if line have the input string, get the index 
            # of that line and put the
            # line into newly created list 
        if text in line:
            new_list.insert(idx, line)
            idx += 1
        
    file_var.close()
    
        # if length of new list is 0 that means 
        # the input string doesn't
        # found in the text file
    if len(new_list)==0:
        print("not found")
    else:
    
        # displaying the lines 
        # containing given string
        lineLen = len(new_list)
        print("\n**** Lines containing \"" +text+ "\" ****\n")
        for i in range(lineLen):
            print(end=new_list[i])
        print()

    return new_list


hostname = find_string(file_var, "hostname")[0].split()[1]

trunks = find_string(file_var, " switchport trunk allowed vlan ")
new_trunks = []
idx = 0
for trunk in trunks:
    new_trunks.insert(idx,trunk.split()[-1])
    idx += 1

trunks = new_trunks
idx = 0
for trunk in trunks:
    for vlan in trunk.split(","):
        new_trunks.insert(idx, vlan)
        idx += 1

print(new_trunks)




