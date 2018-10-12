## Installation
You need Install ruby environment before use this program.

in OS X ```$git clone git@github.com:tinyfeng/git-branch-manager.git && source git-branch-manager/install.sh ```sh


## Usage

Swich a branch existed or new branch with conment, reset branch's comment: `$agt branch-name -m "branch comment"`

List all branch record and message: `$agt -l`

Delete a branch existed: `$agt -d branch-name`

Swich branch existed by number in list: `$agt -s number`


After make a alias, You can use

`agt branch_name branch_massage` to swich a new or old branch, and addictive branch massage or reset it.

`agt -l` to list existed branch and it's massage.

`agt -d branch_name` to delete a existed branch.
