repo.recursive.cloud - Personal Arch/Manjaro Repo
=================================================

[![License](https://img.shields.io/badge/License-BSD%202--Clause-brightgreen.svg?style=flat-square)](LICENSE)

A collection of PKGBUILDs, scripts and helpers to maintain packages for personal machine setup and build packages from the AUR and keep them up to date in the repo.

Requirements
------------

This repo will likely work on [Arch Linux](https://archlinux.org/) but has only been tested on [Manjaro](https://manjaro.org/). To build the packages relies on all dependencies being installed so the best place to build is on a machine that is intended for installation.

Usage:
------

For building and maintaining the repo, the Makefile is self-documenting so run: `make` or `make help` to see help output.

If you would like to use my repository [repo.recursive.cloud](https://repo.recursive.cloud/) to access any prebuilt packages, your system can be bootstrapped with the following:

```
# install the bootstrap package
sudo pacman -U --noconfirm http://repo.recursive.cloud/arch/repo/x86_64/gunzy-init-0.0.3-1-any.pkg.tar.zst
# update package databases
sudo pacman -Syy
# install one of the packages
sudo pacman -S yubioath-desktop-appimage
```

Note: [repo.recursive.cloud](https://repo.recursive.cloud/) is hosted on AWS using Cloudfront, S3 and Cloudfront Functions (headers).

Spotify
-------

GPG is required to build Spotify from the AUR:

```
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | gpg --import -
```

License
-------

BSD 2-Clause License

Author Information
------------------

Created and curated from 2021 onwards by [Ross Williams](http://rosswilliams.id.au/).



