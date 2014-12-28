[![GemVersion](https://badge.fury.io/rb/yaml-lint.svg)](http://badge.fury.io/rb/yaml-lint)
[![TravisBuild](https://travis-ci.org/Pryz/yaml-lint.svg?branch=master)](https://travis-ci.org/Pryz/yaml-lint.svg?branch=master)

yaml-lint
=========

Simple yaml check tool. yaml-lint will simply try to load the YAML file with the
built-in Ruby yaml library.

Install
-------

```shell
gem install yaml-lint
```

Usage
-----

Check a file

```shell
yaml-lint filename.yaml
```

Check a complete folder

```shell
yaml-lint hiera/
```
