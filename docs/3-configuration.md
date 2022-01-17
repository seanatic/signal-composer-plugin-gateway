# Configuration

The config file can be found at `/var/local/lib/afm/applications/signal-composer-binding/etc/control-signal-composer-config.json` after the installation.

## metadata section

```json
"metadata": {
    "uid": "signal-composer-plugin-seanatic-gateway",
    "version": "0.0",
    "api": "",
    "info": "A signal composer plugin meant to catch data from modbus and send it to redis database"
  },
```

## plugins section

```json
"plugins": {
    "uid": "signal-composer-plugin-seanatic-gateway",
    "info": "A signal composer plugin meant to catch data from modbus and send it to redis database",
    "libs": "signal-composer-plugin-seanatic-gateway.ctlso"
  },
```

## Sources section

```json
"sources": [
    {
      "uid": "modbus-binding-ana",
      "api": "modbus",
      "getSignals": {
        "action": "api://modbus#1510SP/ana",
        "args": {
          "action": "SUBSCRIBE"
        }
      }
    },
    {
      "uid": "modbus-binding-dig",
      "api": "modbus",
      "getSignals": {
        "action": "api://modbus#1510SP/dig",
        "args": {
          "action": "SUBSCRIBE"
        }
      }
    }
  ],
```

## Signals section

```json
"signals": [
    {
      "uid": "ANA",
      "event": "modbus/ana",
      "unit": "m/s",
      "onReceived": {
        "action": "plugin://signal-composer-plugin-seanatic-gateway#catch_event_cb"
      }
    },
    {
      "uid": "DIG",
      "event": "modbus/dig",
      "onReceived": {
        "action": "plugin://signal-composer-plugin-seanatic-gateway#catch_event_cb"
      }
    }
  ]
```
