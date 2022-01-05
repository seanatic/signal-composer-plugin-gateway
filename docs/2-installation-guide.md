# Installation guide

## Using package manager

```bash
dnf install signal-composer-plugin-seanatic-gateway
```

## Building from sources

### Tools

* Install the building tools:
  
  ```bash
  gcc g++ make cmake afb-cmake-modules
  ```

* Install the dependencies:
  
  ```bash
  json-c afb-binding afb-libhelpers afb-libcontroller signal-composer-binding
  ```

> **Fedora/OenSuse**
>
> ```bash
> dnf install gcc-c++ make cmake afb-cmake-modules json-c-devel afb-binding-devel afb-libhelpers-devel afb-libcontroller-devel signal-composer-binding-devel
> ```
>
> **Ubuntu/Debian**
>
> ```bash
> apt install gcc g++ make cmake afb-cmake-modules-bin libsystemd-dev libjson-c-dev afb-binding-dev afb-libhelpers-dev afb-libcontroller-dev signal-composer-binding-dev
> ```
>

### Build

```bash
git clone http://git.ovh.iot/seanatic/signal-composer-plugin-seanatic-gateway
cd ssignal-composer-plugin-seanatic-gateway
mkdir build
cd build
cmake ..
make
make install_signal-composer-plugin-seanatic-gateway
```
