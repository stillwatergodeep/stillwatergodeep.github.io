### Git使用

#### 1.本地仓库与远程仓库的关联
1.1在远程服务器创建仓库，本地git clone
1.2在远程服务器常见文件，本地创建同样文件
git init
touch ReadME.md
git add .
git commit -m "first commit"
git remote add origin 远程git地址，如ssh://username@ip:port/***.git
git push -u origin master

#### 2分支管理
##### 2.1策略

分支策略：git上始终保持两个分支，master分支与develop分支。master分支主要用于发布时使用，而develop分支主要用于开发使用。

创建master的分支develop
git checkout -b develop master

切换到master分支
git checkout master

合并develop分支到master
git merge --no-ff develop


除了以上两个常驻分支外，我们还可以适当分支出三种分支：功能分支、预发布分支、修补分支，这三种分支使用完后也该删除，保持两个常驻分支。

功能分支：该分支从develop中分支出来，开发完成后再合并入develop，名字采用feature-* 的形式命名。
创建功能分支：
　　git checkout -b feature-x develop
开发完成后，合并到develop分支：
　　git checkout develop
　　git merge --no-ff feature-x
最后删除分支:
　　git branch -d feature-x


预发布分支：正是版本发布前，既合并到master分支前，因此预发布分支是从develop分支出来的，预发布后，必修合并进develop和master。命名采用release-*的形式。
创建一个预发布分支：
　　git checkout -b release-* develop
确认版本没有问题后，合并到master分支：
　　git checkout master
      git merge --no-ff release-*
对合并生成的新节点，做一个标签：
　　git tag -a 1.2
再合并到develop分支:
　　git checkout decelop
　　git merge --no-ff release-*
最后删除分支:
　　git branch -d release-*



修补分支：主要用于修改bug的分支，从master分支分出来，修补后，在合并进master和develop分支。命名采用fixbug-*形式。
创建一个修补分支：
　　git checkout -b fixbug-* master
修补结束后,合并到master分支:
　　git checkout master
　　git merge --no-ff fixbug-*
　　git tag -a 0.1.1
再合并到develop分支:
　　git checkout develop
　　git merge --no-f fixbug-*
最后删除分支:
　　git branch -d fixbug-*
　　
##### 2.2 创建本地分支关联远程
git checkout -b develop
git push origin dev
//测试从远程获取develop
git pull origin develop
git branch --set -upstream -to =origin/dev，设置默认上传路径

删除本地分支
git branch -d branch name
删除远程分支


　　

