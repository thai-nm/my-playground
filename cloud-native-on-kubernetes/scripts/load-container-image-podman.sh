#! /bin/bash

podman save localhost/note-service:1.0.0 localhost/user-service:1.0.0 -o /tmp/images.tar

kind load image-archive /tmp/images.tar