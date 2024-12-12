import os

DB_CONFIG = [
    {
        "host": "ssdb",
        "port": 8888
    },
    {
        "host": "192.168.11.51",  # 可配置多个db, 自由切换
        "port": 8111
    }
]

SERVICE_CONFIG = {
    "host": "0.0.0.0",
    "port": 5000,
    "debug": False
}

# ENSURE_ASCII = False

VERSION = '3.0.0'

# ------ get config by env(in Docker) ----

db_config = os.getenv("DB_CONFIG", "")  # 127.0.0.1:8888,127.0.0.1:8080
if db_config:
    try:
        DB_CONFIG = [{"host": _.split(":")[0],
                      "port": _.split(":")[1]} for _ in db_config.split(',')]
    except Exception:
        pass

server_host = os.getenv("SERVER_HOST", "")
if server_host:
    SERVICE_CONFIG["host"] = server_host

server_port = os.getenv("SERVER_PORT", "")
if server_port:
    SERVICE_CONFIG["port"] = server_port
