Simple Services Monitor
====================

A Lightweight Approach
--------------------------

This tool brought a lot of value to a team that I was on and was relatively simple to write.  Our team found that we were wasting a bunch of time debugging issues that were caused by external services being down without our knowledge.  I wrote the tool so that it loops through all of our environments and pings these services at a 15min interval.  This provided the team with near real time information on when one of these services went down, greatly reducing the amount of time we spent debugging issues. And we didn't need to roll out a big tool or pay for something to achieve this.

I should mention that the ruby script was added to a Jenkins build to run every 15min.  Each assertion is wrapped in an Rspec test, so test failures represent services not responding the way we expect.  Information on how to configure Jenkins (or any other CI) builds to run at a set interval can be found online.

