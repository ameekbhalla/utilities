Using Git
================

## How does Git store information?

You may wonder what information is stored by each commit that you make.
Git uses a three-level structure for this.

1.  A **commit** contains metadata such as the author, the commit
    message, and the time the commit happened. In the diagram below, the
    most recent commit is at the bottom (`feed0098`), underneath its
    parent commits.

2.  Each commit also has a **tree**, which tracks the names and
    locations in the repository when that commit happened. In the oldest
    (top) commit, there were two files tracked by the repository.

3.  For each of the files listed in the tree, there is a **blob**. This
    contains a compressed snapshot of the contents of the file when the
    commit happened (blob is short for binary large object, which is a
    SQL database term for “may contain data of any kind”). In the middle
    commit, `report.md` and `draft.md` were changed, so the blobs are
    shown next to that commit. `data/northern.csv` didn’t change in that
    commit, so the tree links to the blob from the previous commit.
    Reusing blobs between commits help make common operations fast and
    minimizes storage space.

![](https://assets.datacamp.com/production/repositories/1545/datasets/1bb404075fe1164d8b3fd78f4065b0bf3d86bc16/gds_2_1_SVG.svg)

## The most common steps in a common Git workflow

  - Git records information about the project’s history in the .git file
    in its root directory

  - `git status` displays a list of the files that have been modified
    since the last time changes were saved

  - `git status` shows you which files are in the staging area, and
    which files have changes that haven’t yet been put there.

  - To compare the current version of a file to what you last saved, you
    can use `git diff filename` `git diff` without any file names will
    show you all the changes in your repository (root directory and
    subfolders), while `git diff directory` will show you the changes to
    the files in some directory (subfolders).

  - To add a file to the staging area, use `git add filename`

  - To compare the state of committed (saved) files with those in the
    staging area, you can use `git diff -r HEAD`. The `-r` flag means
    “compare to a particular revision”, and `HEAD` is a shortcut
    meaning “the most recent commit”.

  - You can restrict the results to a single file or directory using
    `git diff -r HEAD path/to/file`

  - To commit a file with a message `git commit -m "some message in
    quotes"`

  - If you accidentally mistype a commit message, you can change it:
    `git commit --amend -m "new message"`

  - `git log` is used to view the log of the project’s history. Git
    shows the log one page of output at a time. Press the space bar to
    go down a page or the ‘q’ key to quit.

  - If you run `git commit` without `-m "message"`, Git launches a text
    editor with a template that contains a couple of commented out
    messages. You can write a longer message in the template; use Ctrl+O
    and Enter to save, and then Ctrl+X to leave the editor

## How to explore a repository’s history

  - To view the details of a specific commit, you use the command `git
    show` with the first few characters of the commit’s hash.

  - A hash is like an absolute path: it identifies a specific commit.
    Another way to identify a commit is to use the equivalent of a
    relative path. The special label `HEAD`, which we saw in the
    previous chapter, always refers to the most recent commit. The label
    `HEAD~1` then refers to the commit before it, while `HEAD~2` refers
    to the commit before that, and so on. Note that there cannot be
    spaces before or after the tilde.

  - `git log` displays the overall history of a project or file, but the
    command `git annotate file` shows who made the last change to each
    line of a file and when. Changes next to identical hashes (first
    column) were made in the same commit and hence get the same hash.

  - there’s another feature of `git log` that will come in handy here.
    Passing `-` followed by a number restricts the output to that many
    commits. For example, `git log -3 report.txt` shows you the last
    three commits involving `report.txt`.

  - `git show` with a commit ID shows the changes made in a particular
    commit. To see the changes between two commits, you can use `git
    diff HASH1..HASH2` or `git diff HEAD~1..HEAD~3`. The pair of dots
    `..` is the connector between two commits.

  - if you don’t want Git to pay attention to any files, create a file
    in the root directory of your repository called `.gitignore` and
    store a list of wildcard patterns in it corresponding to the names
    of those files. Eg if `.gitignore` contains: `build` `*.mpl` Then
    any files or directories containing `build` in their name and
    `*.mpl` files will be ignored

  - `git clean -n` will show you a list of files that are in the
    repository, but whose history Git is not currently tracking. A
    similar command `git clean -f` will then delete those files. `git
    clean` only works on untracked files

  - `ls` to list the files in your current working directory

  - To change the `value` of a `setting` value for all of your projects
    on a particular computer, run the command: `git config --global
    setting value` The settings that identify your name and email
    address are `user.name` and `user.email` respectively.

## How to undo changes

  - Suppose you are adding a feature to `analysis.R` and spot a bug in
    cleanup.R. Since the changes to `cleanup.R` aren’t directly related
    to the work you’re doing in `analysis.R`, you should save your work
    in two separate commits. The syntax for staging a single file is
    `git add path/to/file`. If you make a mistake and accidentally stage
    a file you shouldn’t have, you can unstage the additions with `git
    reset HEAD` and try again.

  - People often save their work every few minutes when they’re using a
    desktop text editor. Similarly, it’s common to use `git add`
    periodically to save the most recent changes to a file to the
    staging area.

  - `git checkout -- filename` undoes all changes to unstaged files
    \[identical to ctrl+z repeatedly\]. Checking out actually leads the
    last saved version of the file. It can be modified to checkout a
    different saved version too as explained below.

  - By combining `git reset` with `git checkout`, you can undo changes
    to a file that you staged changes to. The syntax is as follows `git
    reset HEAD path/to/file` `git checkout -- path/to/file` `git
    checkout 2242bd report.txt` would replace the current version of
    report.txt with the version that was contained in commit starting
    with the hash 2242bd. Notice that this is the same syntax that you
    used to undo the unstaged changes, except – has been replaced by a
    hash.

  - Use `cat path/to/file` to display the contents of a file

  - How can I undo all of the changes I have made? to undo changes to a
    single file at a time use `git reset HEAD path/to/file` `git reset
    HEAD data` will unstage any files from the data directory `git reset
    HEAD` or simply `git reset` will unstage everything. Similarly `git
    checkout -- data` will then restore the files in the data directory
    to their previous state. You can’t leave the file argument
    completely blank, but recall from Introduction to Shell for Data
    Science that you can refer to the current directory as `.`. So `git
    checkout --.` will revert all files in the current directory.

## Branches

  - To list all of the branches in a \[local\] repository, you can run
    the command `git branch`. The branch you are currently in will be
    shown with a `*` beside its name.

  - Branches and revisions are closely connected, and commands that work
    on the latter usually work on the former. For example, just as `git
    diff revision-1..revision-2` shows the difference between two
    versions of a repository, `git diff branch-1..branch-2` shows the
    difference between two branches.

  - You previously used `git checkout` with a commit hash to switch the
    repository state to that hash. You can also use `git checkout` with
    the name of a branch to switch to that branch. Note: Git will only
    let you switch if all of your changes to the current branch have
    been committed.

  - `git rm file_name` removes a file (just like the shell command rm)
    then stages the removal of that file with `git add`, all in one step

  - `ls` lists all the files in a directory

  - In the previous exercise, you used `git checkout branch-name` to
    switch to a branch. To create a branch then switch to it in one
    step, you add a `-b` flag, calling `git checkout -b branch-name`.
    The contents of the new branch are initially identical to the
    contents of the original. Once you start making changes, they only
    affect the new branch.

  - When you merge one branch (call it the source) into another (call it
    the destination), Git incorporates the changes made to the source
    branch into the destination branch. If those changes don’t overlap,
    the result is a new commit in the destination branch that includes
    everything from the source branch (the next exercises describe what
    happens if there are conflicts). To merge two branches, you run `git
    merge source destination` (without `..` between the two branch
    names). Git automatically opens an editor so that you can write a
    log message for the merge.

  - A conflict arises when a file in different branches has been
    modified at the same location. If there is a conflict (it arises )
    when you run `git merge`, Git tells you that there’s a problem, and
    running `git status` after the merge specifies the file causing the
    the conflict by putting `both modified` beside the name(s) of the
    file(s). If you then open the file with a text editor using the
    command `nano file_name`, Git leaves markers (lines containing the
    symbols `<<`, `==`, and `>>`) as shown below to tell you where the
    conflicts occurred. In many cases, instead of
    `destination-branch-name` you will see `HEAD` because you will be
    merging into the current branch. To resolve the conflict, edit the
    file inside the now open text editor to remove the markers and make
    whatever other changes are needed to reconcile the changes, then
    save the file (CTRL+O and Enter), then exit the editor (CTRL+X).
    Then commit the edited file(s).

<!-- end list -->

    <<<<<<< destination-branch-name
    changes-within-the-destination-branch
    =======
    changes-within-the-source-branch..
    >>>>>>> source-branch-name

## Collaborating

  - If you want to create a repository for a new project in the current
    working directory, you can simply say `git init project-name`, where
    “project-name” is the name you want the new repository’s root
    directory to have.

  - To turn an existing project into a Git repository run `git init` in
    the project’s root directory, or: `git init /path/to/project` from
    anywhere else in your computer.

  - Cloning a repository creates a copy of an existing repository
    (including all of its history) in a new directory. To clone a
    repository, use the command `git clone URL`, the `URL` belongs to
    the repository you want to clone. You can even clone an existing
    project on the local file system by putting in the path to it
    instead of a URL. When you clone a repository, Git uses the name of
    the existing repository as the name of the clone’s root directory.
    If you want to call the clone something else, add the directory name
    you want to the command: `git clone /existing/project
    newprojectname`

  - To find out where a cloned repository originated use `git remote
    -v`(for “verbose”), which shows the remote’s URLs. Git remembers
    where the original repository by storing a “remote” in the clone
    repository’s configuration. A remote is like a browser bookmark with
    a name and a URL. It’s possible for a remote to have several URLs
    associated with it for different purposes, though in practice each
    remote is almost always paired with just one URL.

  - You can add more remotes using: `git remote add remote-name URL` and
    remove existing ones using: `git remote rm remote-name`. You can
    connect any two Git repositories this way, but in practice, you will
    almost always connect repositories that share some common ancestry.

  - the command `git pull remote branch` gets everything in `branch` in
    the remote repository identified by `remote` and merges it into the
    current branch of your local repository.

  - To push changes to a remote repository the command is `git push
    remote-name branch-name`. It pushes the contents of your branch
    `branch-name` into a branch with the same name in the remote
    repository associated with `remote-name`.
