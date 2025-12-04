#!/bin/bash

# Print the logo
print_logo() {
    cat << "EOF"
    __________  __  ______  __  __
   / ____/ __ \/ / / / __ )/ / / /
  / /_  / /_/ / / / / __  / / / / mostly automated
 / __/ / _, _/ /_/ / /_/ / /_/ /  Custom Ubuntu Setup
/_/   /_/ |_|\____/_____/\____/   by and mainly for Frank

EOF
}

# Print the done message
print_done() {
    cat << "EOF"
         __                     __                         __     
  ____ _/ /___ ___  ____  _____/ /_   ________  ____ _____/ /_  __
 / __ `/ / __ `__ \/ __ \/ ___/ __/  / ___/ _ \/ __ `/ __  / / / /
/ /_/ / / / / / / / /_/ (__  ) /_   / /  /  __/ /_/ / /_/ / /_/ / 
\__,_/_/_/ /_/ /_/\____/____/\__/  /_/   \___/\__,_/\__,_/\__, /  
                                                         /____/                                                      
.. a few steps to (still) do manually before your FRUBU ready.

== Resilio Sync ==
- https://127.0.0.1:8888/
- Add the licence from Proton Pass
- Setup the Sync directories

EOF
}

# Clear screen and show logo
clear
print_logo



print_done
