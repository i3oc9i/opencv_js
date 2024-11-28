# OpenCV.js - OpenCV JavaScript

## Description

This is a simple example of how to use OpenCV.js in a web application.
The example uses a simple image processing denoising algorithm to remove noise from an image.

## Requirements

First of all, you need to clone the `opencv` repository.

The makefile will clone the repository in the same directory as this repository, and
chekcout the `4.10.0` version.

```bash
make clone
```

## Build

To build all the versions, run the following command:

```bash
make build_all
```

or, one of the following commands:

```bash
make build_default
make build_simd
make build_simd_threads
```

or just execute `make` to help you with the available commands
