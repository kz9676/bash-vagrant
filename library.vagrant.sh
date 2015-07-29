#!/usr/bin/env bash

: '

This file is part of library.vagrant.sh - collection of Vagrant helper scripts
and utilities. 

The MIT License (MIT)

Copyright (c) 2015 Kostya Zolotarov

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

'

# https://github.com/kz9676/library.log.sh
. library.log.sh

# Script file name has to be hardcoded due to the fact that the script 
# is intended for inclusion and as such automatic resolution with 
# shell directive ${PWD##*/} would produce the name of host script instead.
file_name='library.vagrant.sh'

# Exit codes 
error_none=0
error_vagrant_box_name_not_set=1
error_vagrant_box_not_installed=2
error_vagrant_box_installed=$error_none

# Exit messages
text_vagrant_box_name_not_set="Vagrant box name not set"
text_vagrant_box_not_installed="Vagrant box %s not installed"
text_vagrant_box_installed="Vagrant box %s found installed"

# FUNCTION:
#
#   is_vagrant_box_installed
#
# BACKGROUND:
#
#   If Vagrant box you are trying to add with 'vagrnat box add <box name>'
#   already exists, Vagrant will throw the following error - "The box
#   you are attempting to add already exists. Remove it before adding
#   it again or add it with the '--force' flag."
#
# DESCRIPTION:
#
#   This function returns 0 if a particular Vagrant box already exists 
#   or, in other words, the box with the same name has previously been 
#   added with 'vagrant box add <box name>' command.
#
# EXAMPLES:
#
#   1) Invocation in Bash terminal
#
#       $ source library.vagrant.sh
#       $ is_vagrant_box_installed centos-6.5-amd64-box
#
#   2) Inclusion in Bash script 
#
#       #!/usr/bin/env bash 
#       . library.vagrant.sh
#       vagrant_box_name=$1
#       if [ is_vagrant_box_installed $vagrant_box_name ]; then 
#           # Your code here... 
#       fi
#
is_vagrant_box_installed() {

    vagrant_box_name=$1

    if test -z $vagrant_box_name;
    then
        printf "$error $file_name - $text_vagrant_box_name_not_set\n" >&2
        return $error_vagrant_box_name_not_set 
    fi 

    result=`vagrant box list "$vagrant_box_name"`

    # Sadly, `vagrant box list` does not implement exit codes.  
    # No matter if a specified vagrant box is installed or not, 
    # the exit code is always 0. We have to rely on parsing vagrant 
    # exit text messages, to achieve desired degree of automation.
    if [ "$result" == 'There are no installed boxes! Use `vagrant box add` to add some.' ];
    then
        printf "$error $file_name - $text_vagrant_box_not_installed\n" "$vagrant_box_name" >&2
        return $error_vagrant_box_not_installed
    else 
        printf "$success $file_name - $text_vagrant_box_installed\n" "$vagrant_box_name" >&2 
        return $error_vagrant_box_installed
    fi 

}

