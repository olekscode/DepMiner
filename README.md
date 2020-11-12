# DepMiner

[![Build Status](https://travis-ci.org/olekscode/DepMiner.svg?branch=master)](https://travis-ci.org/olekscode/DepMiner)
[![Build status](https://ci.appveyor.com/api/projects/status/t7lxsakunjyl0dan?svg=true)](https://ci.appveyor.com/project/olekscode/depminer)
[![Coverage Status](https://coveralls.io/repos/github/olekscode/DepMiner/badge.svg?branch=master)](https://coveralls.io/github/olekscode/DepMiner?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/olekscode/DepMiner/master/LICENSE)

## How to install it?

To install `DepMiner`, go to the Playground (Ctrl+OW) in your [Pharo](https://pharo.org/) image and execute the following Metacello script (select it and press Do-it button or Ctrl+D):

```Smalltalk
Metacello new
  baseline: 'DepMiner';
  repository: 'github://olekscode/DepMiner/src';
  load.
```

## How to depend on it?

If you want to add a dependency on `DepMiner` to your project, include the following lines into your baseline method:

```Smalltalk
spec
  baseline: 'DepMiner'
  with: [ spec repository: 'github://olekscode/DepMiner/src' ].
```

If you are new to baselines and Metacello, check out the [Baselines](https://github.com/pharo-open-documentation/pharo-wiki/blob/master/General/Baselines.md) tutorial on Pharo Wiki.

## How to use it?

