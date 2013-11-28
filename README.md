## hdfs-shell

Simple CLI/Shell for the Hadoop DFS which makes HDFS exploration easier

### Introduction

This is a very simple wrapper around the 'hadoop dfs' command that allows you to cd through DFS like in a normal shell. It will accept any of the usual hadoop dfs command, but will remember your current working dir.

### Installation
	wget https://raw.github.com/thekroko/hdfs-shell/master/hdfs.sh && chmod +x hdfs.sh

### Example usage
	./hdfs.sh

	hdfs:/user/foobar> ls
	Found 2 items
	drwxr-xr-x   - foobar supergroup          0 2013-10-24 11:51 /user/foobar/data
	drwxr-xr-x   - foobar supergroup          0 2013-10-24 11:04 /user/foobar/source
	
	hdfs:/user/foobar> rmr data
  	Deleted hdfs://XX.ac.uk/user/foobar/data

### Commands
Browing around:
	cd ../
	cd foo/
	ls foo

Changing files:
	touchz foo.txt
	cat foo.txt
	tail foo.txt
	cp foo.txt foo2.txt
	mkdir bar
	rmr bar

Copying file from/to local:
	put ~/local.txt remote.txt
	get remote.txt ~/local.txt


And any other command supported by 'hadoop dfs'

### Known Bugs/Limitations
* No support for spaces in paths/file names
* Unmentioned hadoop commands that take two or more path arguments might fail due to missing path expansion

