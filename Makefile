MESSAGE=$(filter-out $@,$(MAKECMDGOALS))
all:
	/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin/swift build

setup:
	git init ; git add . ; git commit -m "Commit"
	git tag -a 1.0.0 -m "Version 1.0.0" 
	git remote add origin https://github.com/erica/SwiftString.git
	git push -u origin master
	git push --tags

pull: 
	git clone https://github.com/erica/SwiftString.git

push:
	git add -A
	git commit -m "$(MESSAGE)"
	git push
	echo "git tag -a 1.0.x -m message-in-quotes"
	echo "git tag -d 1.0.0"
	echo "make pushtag"

pushtag:
	git push --tags

cleaner:
	rm -rf .build
	rm -rf .git

clean:
	rm *~ Sources/*~
	rm .DS_Store
	rm */.DS_Store

show:
	git tag
	git log --pretty=oneline
