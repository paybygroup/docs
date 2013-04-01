

### Deployment Steps

PayByGroup deploys code to our production environment in two ways.
- As a hotfix
- As a standard batched merge and push to prod


# PREP LETS2 FOR PRODUCTION PUSH TESTING
$ git checkout dev
$ git merge master           # should be upto date unless hotfix occurred
$ chrome http://github.com   # pull in ready PRs
$ ./pbgtest -r spec/requests/general_flow_spec.rb 


# REVERSING FAILED PULL REQUESTS
# (1) Don't.  Just fix pull request and delay push to production by a day or two.
# (2) Reset head backwards as shown here
#     NOTE: critical that dev was not pushed to master, OR used by anyone during this time
#           perhaps all branches should be created from master, but then merged into dev?
$ git reset --hard ppYYMMDD  # use the prior production pull tag or any ssha
$ git merge [branch]         # manually load other correct pull requests that were closed 
$ git push


# Push to production
$ git checkout dev
$ git merge master      # should be upto date unless hotfix occurred
$ git tag -a ppYYMMDD   # Creates a tag 'pp'  (production push with the current date)
$ git push
$ git checkout master
$ git merge dev
$ cap production deploy