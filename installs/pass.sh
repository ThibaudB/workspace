#!/bin/sh
sudo apt-get install pass

# Generate a key
gpg --full-generate-key

# TODO ask for keystore or diff the key store in order to get the new key name
pass init $keystore
