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

error_none=0
error_vagrant_box_not_found=1

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
if_vagrant_box_exists() {
    vagrant_box_name=$1
    vagrant box list $vagrant_box_name
    if [ $? -ne 0 ];
    then
        exit $error_vagrant_box_not_found
    else  
        exit $error_none
    fi 
}

