=begin
#---What is Git?---
Git is a Version Control System that uses branches.

#---How does it work?---

- Git stores data as a serie of snapshots, every time you make a commit

- Git performs most operations locally.

- A master copy of each repository usually lives in a remote location, like
Github, but each contributor also keeps a copy of the repo locally. 
So if we want to check out past changes or save new changes,
there's no need to fetch data from the server every time.

- Only when we want to push our changes to the master copy or grab other contributors
changes we need to push/fetch from Github.

#---What are the states of Git?---
- Working Directory 
  Here we make the changes. Files are now *modified*

- Staging Area
  Here we decide which files we want to add to pur next commit by adding
  them to Staging Area. Files are now *staged*

- .git directory/Repository
  Files in the staging area are committed, creating a snapshop which permanently
  lives in your local Git directory. Files are now *committed*

#---Git commands---

`git init` 
  setups a git repository/empty repo inside the current directory.
  Do this before writing any code.
  We should create the repo at the root level of the project so it 
  tracks all its children.

`git remote add your_alias https://github.../repo_name`
  `git remote` : interacts with remote repositories
  `add` (not the same as git add, it's a git remote command):
    adds a remote repo to the current local repo
  `your_alias` : sets a name you can use locally to refer to the remote repo
    **use `origin` 
  `https://github.../repo_name` : sets the locations of the repo

  This way we have: 
    + local repo(stored in .git directory) 
    + remote repo(which we can reference with `your_alias`)

`git status`
  checks what modified files have not been staged 
  + what files are not being tracked.

`git add <file>/ -A`
  adds files to staging.
  Theses files will be saved in the repo when they get committed.
  ** if we git add changes of a file to staging and later on, we make more changes
  and commit and don't git add the latest changes again, they will not show in the commit
  -A, (git add. + git add -u), finds new files + updates old files

`git ad .`  (current directory)
  adds ALL new and changes of current directory and adds to staging
  ** avoid this

`git add -u` (update)
  updates already tracked files and removes them from staging area

`git commit -m "Some comment"`
  will save the staged work into the history. We will always be able to return 
  to this point.
  Always be descriptive and start with an imperative verb 

`git reset <file>`
  unstages staged changes

`git push`
  pushes local commits to remote repo.
  ** First we run this, `git push -u your_alias master`
    this will set the master branch in your_alias remote repo.
  ** To push to a particular remote, `git push remote_name branch_name`
    e.g `git push origin master`

`git log`
  we can see all commits

`git co master`
  we check out master

`git diff`/ `git diff --staged`
  shows specifically what has been changed / diff from prev staging

`git reset <lib/file.rb> / --hard` 
  reset specific file to previous commit or reset all

`git checkout -b branch_name`
  creates branch and switches to that branch

`git push -f`/ `git push --force`
  overrides any conflicts our local repo has with the remote repo

#---How often commit & push?---
Frequently, whenever you make sthng and IT WORKS


  
=end