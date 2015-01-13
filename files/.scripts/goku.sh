#
#            ___     -._
#            `-. """--._ `-.
#               `.      "-. `.
# _____           `.       `. \       
#`-.   """---.._    \        `.\
#   `-.         "-.  \         `\
#      `.          `-.\          \_.-""""""""--._
#        `.           `                          "-.
#          `.                                       `.    __....-------...
#--..._      \                                       `--"""""""""""---..._
#__...._"_-.. \                       _,                             _..-""
#`-.      """--`           /       ,-'/|     ,                   _.-"
#   `-.                 , /|     ,'  / |   ,'|    ,|        _..-"
#      `.              /|| |    /   / |  ,'  |  ,' /        ----"""""""""_`-
#        `.            ( \  \      |  | /   | ,'  //                 _.-"
#          `.        .'-\/'""\ |  '  | /  .-/'"`\' //            _.-"
#    /'`.____`-.  ,'"\  ''''?-.V`.   |/ .'..-P''''  /"`.     _.-"
#   '(   `.-._""  ||(?|    /'   >.\  ' /.<   `\    |P)||_..-"___.....---
#     `.   `. "-._ \ ('   |     `8      8'     |   `) /"""""    _".""
#       `.   `.   `.`.b|   `.__            __.'   |d.'  __...--""
#         `.   `.   ".`-  .---      ,-.     ---.  -'.-""
#           `.   `.   ""|      -._      _.-      |""
#             `.  .-"`.  `.       `""""'       ,'
#               `/     `.. ""--..__    __..--""
#                `.      /7.--|    """"    |--.__
#                  ..--"| (  /'            `\  ` ""--..
#               .-"      \\  |""--.    .--""|          "-.
#              <.         \\  `.    -.    ,'       ,'     >
#             (P'`.        `%,  `.      ,'        /,' .-"'?)
#             P    `. \      `%,  `.  ,'         /' .'     \
#            | --"  _\||       `%,  `'          /.-'   .    )
#            |       `-.""--..   `%..--"""\\"--.'       "-  |
#            \          `.  .--"""  "\.\.\ \\.'       )     |
#

# Update kits
function ku() {
 pushd ~/.kit
 rm -Rf packages
 git pull
 popd
}

# Find a project in various directories. Change them to whatever suits you
function fp() {
 echo `find $HOME/Projects/Cogent $HOME/Projects/Oomph $HOME/Projects/Pelofy $HOME/Projects/Personal $HOME/Projects/open_source -maxdepth 1 | grep /\[\^/\]\*$1\
\[\^/\]\*$ | head -n 1`
}

# Go to a particular project
function go () {
 local PROJECT=`fp $1`

 if [ -n "$PROJECT" ]
 then
   cd "$PROJECT"
 else
   echo "There is no project like:" $1
 fi
}

function ku() {
  pushd ~/.kit && rm -Rf packages && git pull && popd
}

# Update a particular project
function gu() {
  if [ -n "$1" ]; then
    local PROJECT=`fp $1`
  else
    local PROJECT=`pwd`
  fi

  if [ -d "$PROJECT" ]; then
    pushd "$PROJECT"
    git fetch origin && git rebase -p
    kit
    popd
  fi
}

# Update everything
function goku() {
  if [ -n "$1" ]; then
    local PROJECT=`fp $1`
  else
    local PROJECT=`pwd`
  fi

  echo "\nUpdating Kits..."
  ku

  if [ -d "$PROJECT" ]; then
    if [ -d "$PROJECT/dev-packages" ]; then
      for package in `ls -r $PROJECT/dev-packages`; do
        echo "\nUpdating $package"
        gu "$package"
      done
    fi
  fi

  echo "\nUpdating `basename $PROJECT`"
  gu `basename $PROJECT`
  go `basename $PROJECT`
}

