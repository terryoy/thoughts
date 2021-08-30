#!/bin/sh


echo if you want to setup with RubyGems mirror, try:
echo https://gems.ruby-china.com/
echo
echo "gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/"
echo "gem sources -l"
echo 

echo "if you have an older version of ruby and bundler"
echo "sudo apt install ruby2.5 ruby2.5-dev"
echo "sudo gem install bundler"
echo

gem install bundler jekyll

