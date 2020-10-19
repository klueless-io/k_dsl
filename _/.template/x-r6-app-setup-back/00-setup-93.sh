#!/bin/sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

function kl_exit_error {
  echo "missing dependency: $1"
  exit -1
}
function kl_heading {
  kl_line
  echo $1
  kl_line
}
function kl_subheading {
  echo -e "[ \e[93m$1\e[0m ]"
}
function kl_line {
  echo '----------------------------------------------------------------------'
}
function kl_cmd {
  # -n = NO Line Feed
  # echo -n ": $1 : "
  echo -n "[ $1 ]"
}
function kl_cmd_end {
  # echo ":[ OK ]"
  echo " - OK"
}
function kl_cmd_done {
  echo "  $1"
}

kl_heading 'Make hooks and bin files executable'

chmod +x hooks/update-version
chmod +x hooks/pre-commit
chmod +x bin/k
chmod +x bin/kgitsync
chmod +x bin/khotfix
chmod +x bin/kmigrate
chmod +x bin/krollback

kl_heading 'Build development and test databases'

./bin/kmigrate

kl_heading 'Seed single admin user'

rake db:seed

kl_heading 'Final application commit (.git)'

git status
git add .
git commit -am 'Microservice Application'
echo 'git status'

kl_heading 'Setup git flow'

git flow init
git status
git branch
git checkout master
git status

git remote add origin git@bitbucket.org:{{settings.BitBucketAccount}}/{{dashify settings.Application}}.git

kl_heading 'Push to Master'

git push --set-upstream origin master

kl_heading 'Push to Develop'

git checkout develop
git push --set-upstream origin develop

kl_heading 'Create first hotfix manually'

git flow hotfix start v0.01.001

# alter the readme file so that we have something to add to .git
cat " " >> README.md

git add .
git commit -am 'First Hotfix, setup the version system and alter seed.rb'
git flow hotfix finish v0.01.001
git push

git checkout master
git push

kl_subheading 'Completed Tasks'
kl_cmd_done 'make automation scripts executable'
kl_cmd_done 'run common migrations for development and test databases'
kl_cmd_done 'add seed single admin user'
kl_cmd_done 'git commit - "Microservice Application"'
kl_cmd_done 'setup git flow'
kl_cmd_done 'push master branch'
kl_cmd_done 'push develop branch'
kl_cmd_done 'create first hot fix: 0.01.001'

kl_heading 'First hotfix verion pushed: 0.01.001'
echo ''
echo 'Application is now ready to be built using the'
echo 'Klueless.io Software Factory'
echo ''
echo 'You should remove setup1.sh setup2.sh and setup3.sh'
echo '  rm setup-?.sh'
echo ''
echo 'The following commands may also be useful'
echo ''
echo 'WARNING: If angular is not working then try the following'
echo 'https://stackoverflow.com/questions/55319694/rails-webpacker-angular-polyfills-ts-error-cant-resolve-core-js-es6-refle'
echo ''

./bin/k
