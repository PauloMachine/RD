import os
from decouple import config

# Application
HEADLESS = config("HEADLESS", True, bool)
CAPTURE_EVIDENCE = config("CAPTURE_EVIDENCE", True, bool)
LOG_LEVEL = config("LOG_LEVEL", "INFO")
SPEED = config("SPEED", 0.1)
TIMEOUT = config("TIMEOUT", 15)
REMOTE_URL = config("REMOTE_URL", "http://127.0.0.1:4723/wd/hub")
AUTOMATION_NAME = config("REMOTE_URL", "UiAutomator2")
PLATFORM_NAME = config("REMOTE_URL", "Android")
DEVICE_NAME = config("REMOTE_URL", "Google Pixel 7 Pro")
APP = config("APP", "app.apk")

# URL
ORANGE_HRM_URL = "https://opensource-demo.orangehrmlive.com"
VIACEP_URL = "https://viacep.com.br"
