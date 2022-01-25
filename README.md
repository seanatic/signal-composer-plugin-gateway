# Signal composer plugin seanatic gateway

The signal composer plugin needs the signal-composer-binding to work.

```bash
dnf install signal-composer-binding
```

This plugin subscribes to modbus event and send data to redis database. It requires 2 more services:

* modbus-binding
* redis-tsdb-binding

```bash
dnf install modbus-binding redis-tsdb-binding
```

## I - Architecture presentation

![project schema](./docs/img/project_schema.png)

This plugin is a part of the seanatic gateway project. Allowing to store data from *modbus-binding* to redis database thanks to *redis-tsdb-binding*

## II - Installation guide

### a) Using package manager

```bash
dnf install signal-composer-plugin-seanatic-gateway
```

### b) Building from sources

#### 1. Tools

* Install the building tools:
  
  ```bash
  gcc g++ make cmake afb-cmake-modules
  ```

* Install the dependencies:
  
  ```bash
  json-c afb-binding afb-libhelpers afb-libcontroller signal-composer-binding
  ```

> **Fedora/OpenSuse**
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

#### 2. Build

```bash
git clone http://git.ovh.iot/seanatic/signal-composer-plugin-seanatic-gateway
cd signal-composer-plugin-seanatic-gateway
mkdir build
cd build
cmake ..
make
make install_signal-composer-plugin-seanatic-gateway
```

### III - Documentations

1. [Architecture presentation](./docs/1-architecture-presentation.md)
2. [Installation guide](./docs/2-installation-guide.md)
3. [Configuration](./docs/3-configuration.md)
4. [Usage guide](./docs/4-usage-guide.md)
