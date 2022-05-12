# Changes the terminal prompt
#
# Show the username in green
# \[\033[01;32m\]\u \[\] 
# 
# Show the directory and branch in blue
#                        \[\033[01;34m\]\w\[\]$(__git_ps1 " (%s)") \[\033[00m\]
#
# End the prompt with $ on a new line
#                                                                              \n$
#
# Example
# 
# gitpod /workspace/new (main)
# $

PS1='\[\033[01;32m\]\u\[\] \[\033[01;34m\]\w\[\]$(__git_ps1 " (%s)") \[\033[00m\]\n$ '
