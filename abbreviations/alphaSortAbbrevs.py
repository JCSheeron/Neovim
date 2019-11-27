#!/usr/bin/env python3
# -*- coding: UTF-8 -*-

# imports
# import arg parser
import argparse

# import itemgetter to speed sorting the list
#from operator import itemgetter

# **** argument parsing
# define the arguments
# create an epilog string to further describe the input file
eplStr="""Specify the abbreviation list to alphabetize. The list is assumed to 
be in the format:
cmd abbreviation target
This function will alphabetize the file by the abbreviation, so the list can
be easily searched for by abbreviation. Lines with commands that do not assign
abbreviations or lines that are incomplete (no target) will be ignored, and not 
included in the output file.  The target can be multiple words."""

descrStr="Alphabetize abbreviation list."
parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter, \
                                 description=descrStr,
                                 epilog=eplStr)
parser.add_argument('inf', default='', \
                    help='Input abbreviation file.')
parser.add_argument('outf', default='', \
                    help='Ouput abbreviation file.')
args = parser.parse_args()

# At this point, the arguments will be:
# Argument          Values      Description
# args.inf          string      Input (source) abbreviation list file name
# args.outf         string      Output (dest) sorted abbreviation list file name

# *** Check for an input and output file.
# They are required
if args.inf == '':
    print('An input file name must be specified.')
    quit()

if args.outf == '':
    print('An output file name must be specified.')
    quit()

abbList=[]
# accepted abbreviation createion related commands
# Use a set for fast membership checking
abCmds={':ab', 'ab', ':abbreviate', 'abbreviate',
        ':abbreviate-local', 'abbreviate-local',
        ':abbreviate-<buffer>', 'abbreviate-<buffer>',
        ':norea', 'norea', ':noreabbrev', 'noreabbrev',
        ':ca', 'ca', ':cabbrev', 'cabbrev',
        ':cnorea', 'cnorea', ':cnoreabbrev', 'cnoreabbrev',
        ':ia', 'ia', ':iabbrev', 'iabbrev',
        ':inorea', 'inorea', ':inoreabbrev', 'inoreabbrev'}

# *** Read the input file and make a list of (cmd, alias, target) tuples
with open(args.inf, 'r') as inf:
    # for each line, make a list of the words, delimited by whitespace
    for line in inf:
        splitList = line.split() #defaults to white space, not just space
        # format is cmd alias target
        # ignore the line if there isn't at least 3 elements
        if len(splitList) >= 3:
            cmd = splitList[0]
            # continue if the command is in the above set
            if cmd in abCmds:
                alias = splitList[1]
                # Concat all other elements into the target string.
                # The target string can be multiple words.
                target = ' '.join(splitList[2:])
                # append a (cmd, alias, target) tuple to the abbreviation list
                abbList.append((cmd, alias, target))

# Now we have a list of valid abbreviations
# Sort the abbreviation list by the alias (2nd tuple element)
#  itemgetter is fastest, but want to sort regardless of case, so  use the lambda version
# abbList = sorted(abbList, key=itemgetter(1))
abbList = sorted(abbList, key=lambda x: x[1].lower())

# now write the sorted list to the output file
# an existing file will first be cleared.
with open(args.outf, 'w') as outf:
   outf.write('\n'.join('%s %s %s' % item for item in abbList)) 
