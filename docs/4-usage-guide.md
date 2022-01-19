# Usage Guide

## Worflow

1. Subscribe to the events of the modbus
2. Catch data and push to redis-tsdb-binding

## Redis Database

Redis package contained a client that can let you see which values are stored in your database. This plugin add classes to the database corresponding to the uid of the signal so `ANA` and `DIG` in our project to each value stored in Redis.

* To retrieve the last value of each sensor, run in a terminal:

    ```bash
    redis-cli -c TS.MGET FILTER class=SIEMENS_ET200SP
    1) 1) "ANA[0]"
   2) (empty list or set)
   3) 1) (integer) 1642431058052
      2) 1
    2) 1) "ANA[1]"
    2) (empty list or set)
    3) 1) (integer) 1642431058052
        2) 1
    3) 1) "ANA[2]"
    2) (empty list or set)
    3) 1) (integer) 1642431058051
        2) 1
    4) 1) "ANA[3]"
    2) (empty list or set)
    3) 1) (integer) 1642431058051
        2) 1
    5) 1) "ANA[4]"
    2) (empty list or set)
    3) 1) (integer) 1642431058051
        2) 1
    6) 1) "ANA[5]"
    2) (empty list or set)
    3) 1) (integer) 1642431058051
        2) 1
    7) 1) "ANA[6]"
    2) (empty list or set)
    3) 1) (integer) 1642431058050
        2) 0
    8) 1) "ANA[7]"
    2) (empty list or set)
    3) 1) (integer) 1642431058050
        2) 1
    ```

* To see the whole database content, run the following command:

    ```bash
    redis-cli -c TS.MRANGE - + FILTER class=SIEMENS_ET200SP
    1) 1) "ANA[0]"
    2) (empty list or set)
    3)  1) 1) (integer) 1642431048840
            2) 1
        2) 1) (integer) 1642431049052
            2) 0
        3) 1) (integer) 1642431049303
            2) 0
        4) 1) (integer) 1642431049552
            2) 0
        5) 1) (integer) 1642431049803
            2) 0
        6) 1) (integer) 1642431050052
            2) 1
    # [...]
    2) 1) "ANA[1]"
    2) (empty list or set)
    3)  1) 1) (integer) 1642431048839
            2) 1
        2) 1) (integer) 1642431049051
            2) 0
        3) 1) (integer) 1642431049303
            2) 1
        4) 1) (integer) 1642431049552
            2) 1
        5) 1) (integer) 1642431049802
            2) 1
        6) 1) (integer) 1642431050052
            2) 1
    # [...]
    ```
