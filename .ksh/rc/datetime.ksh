#!/usr/bin/env ksh

# date and time dicicpline functions

function DATE.get { .sh.value=$(date +%D) ; }

function TIME.get { .sh.value=$(date +%r) ; }

function DATETIME.get { .sh.value=$(date +%c) ; }
