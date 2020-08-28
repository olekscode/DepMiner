# MigrationRulesMiner

[![Build Status](https://travis-ci.org/olekscode/MigrationRulesMiner.svg?branch=master)](https://travis-ci.org/olekscode/MigrationRulesMiner)
[![Build status](https://ci.appveyor.com/api/projects/status/ify7vkcfe4a5gp6b?svg=true)](https://ci.appveyor.com/project/olekscode/migrationrulesminer)
[![Coverage Status](https://coveralls.io/repos/github/olekscode/MigrationRulesMiner/badge.svg?branch=master)](https://coveralls.io/github/olekscode/MigrationRulesMiner?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/olekscode/MigrationRulesMiner/master/LICENSE)

## How to install it?

To install `MigrationRulesMiner`, go to the Playground (Ctrl+OW) in your [Pharo](https://pharo.org/) image and execute the following Metacello script (select it and press Do-it button or Ctrl+D):

```Smalltalk
Metacello new
  baseline: 'MigrationRulesMiner';
  repository: 'github://olekscode/MigrationRulesMiner/src';
  load.
```

## How to depend on it?

If you want to add a dependency on `MigrationRulesMiner` to your project, include the following lines into your baseline method:

```Smalltalk
spec
  baseline: 'MigrationRulesMiner'
  with: [ spec repository: 'github://olekscode/MigrationRulesMiner/src' ].
```

If you are new to baselines and Metacello, check out the [Baselines](https://github.com/pharo-open-documentation/pharo-wiki/blob/master/General/Baselines.md) tutorial on Pharo Wiki.

## How to use it?

```Smalltalk
repository := IceRepository registry
   detect: [ :repo | repo name = 'APriori' ].

changeHistory := MRChangeHistory new
   repository: repository;
   branchNamed: 'master';
   fromCommitId: '14164de82d938df2cc98186fa0225a49fe7c98e0';
   toCommitId: '3206cc82d9991e2acdd10916247c114e1b173e77';
   yourself.
	
changeHistory loadCommits.
changeHistory calculateDiffs.
changeHistory extractMethodChanges.
	
aprioriMiner := MRAprioriMiner new
   changeHistory: changeHistory;
   yourself.

aprioriMiner collectTransactions.
aprioriMiner mineRulesWithMinCount: 4.
```
