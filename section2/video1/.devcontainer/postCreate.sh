#!/bin/bash
set -e

apt-get update
apt-get install -y gdb
wget -P /tmp https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-30/wasi-sdk-30.0-arm64-linux.tar.gz
tar -xzf /tmp/wasi-sdk-30.0-arm64-linux.tar.gz -C /tmp
mv /tmp/wasi-sdk-30.0-arm64-linux /opt/wasi-sdk
curl https://wasmtime.dev/install.sh -sSf | bash
