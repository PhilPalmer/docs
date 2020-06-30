---
title: Bash
linktitle: Bash
toc: true
type: docs
date: "2019-05-05T00:00:00+01:00"
draft: false
menu:
  computing:
    parent: Tools
    weight: 2

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 2
---
Bash is a languauge used in UNIX environments. The basic/most used commands are:

```bash
ls         # list files
cd         # change directory
mkdir      # make directory
touch      # make file
cat        # print contents of file
mv         # move file
cp         # copy file
rm         # remove file
chmod      # change file permissions
man        # view mannual pages
```

You can see a more comprehensive list [here](https://github.com/LeCoupa/awesome-cheatsheets/blob/master/languages/bash.sh)

## Useful bash commands

### Keyboard shortcuts

```bash
Ctrl + A    # move to start of the line
Ctrl + E    # move to end of the line
Ctrl + C    # kill the current command
Ctrl + Z    # put command to sleep (bg & fg used to run in background & foreground respectively)
Ctrl + R    # search previous commands
Ctrl + L    # clear the screen
```

### Commands

```bash
cd -                            # return to previous directory
du -h --max-depth=1 | sort -hr  # check folder size & return largest to smallest
export PATH=$PATH:/usr/bin      # add /usr/bin to the path
find . -name "pattern" -print   # print files & directories in the current directory that match pattern
tar -xvzf                       # extract .tar.gz file
which                           # find location of executable
grep <pattern> <filename>       # find pattern in file
sed 's/a/b/g'                   # replace a with b
uname -a                        # shows kernel information
df -h                           # return storage/disk spaace information
wget                            # download file
```


### Scripting

```bash
varname=value           # declare a variable
array=(valA valB valC)  # define an array
${array[i]}             # displays array's value for this index
$(UNIX command)         # command substitution: runs the command and returns standard output
```

```bash
if condition
then
  statements
[elif condition
  then statements...]
[else
  statements]
fi

for x in {1..10}
do
  statements
done

for name [in list]
do
  statements that can use $name
done

while condition; do
  statements
done
```

### Other 
Store official binaries in: `/usr/bin`
Store unofficial binaries in: `/usr/local/bin`


### Tools
Use [axel](https://github.com/axel-download-accelerator/axel) to download large files in parrallel

## awk

Append chr to bed file:
```bash
awk '{print "chr" $0;}' genes_hg19.bed > chr_genes_hg19.bed
```

Print columns from comma separated file:
```bash
awk -F',' '{print $3}' myfile.txt
```

Read file as tab delimited:
```bash
awk 'BEGIN {OFS = FS} {print $3}' file.tsv
```

Print columns tab separated:
```bash
awk '{print $1,"\t",$2}' file.tsv
```

Print lines where the value in the first column is true:
```bash
awk '$1 == "true" {print $0}' file.txt
```

## tmux
Tmux lets you run multiple sessions/programs within one terminal. On Mac [iTerm2](https://www.iterm2.com/) has good support for tmux

```bash
# open new tmux session
tmux

# run command

# disconnect 
Ctrl + B, D

# list sessions
tmux ls

# attach session
tmux attach
# or
tmux a -t myname

# leave
exit
```

See a more complete list of tmux commands [here](https://gist.github.com/MohamedAlaa/2961058)