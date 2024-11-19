import requests
from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn
from rd_automation.libraries.settings import (
    APP,
    AUTOMATION_NAME,
    CAPTURE_EVIDENCE,
    DEVICE_NAME,
    HEADLESS,
    LOG_LEVEL,
    PLATFORM_NAME,
    REMOTE_URL,
    SPEED,
    TIMEOUT,
    ORANGE_HRM_URL,
    VIACEP_URL
)

requests.packages.urllib3.disable_warnings()


class Manage:
    ROBOT_LISTENER_API_VERSION = 3

    def __init__(self):
        self.passed_tests = []
        self.failed_tests = []

    @keyword(name="Set Global Variables")
    def set_global_variables(self, **variables):
        for var_name, var_value in variables.items():
            BuiltIn().set_global_variable("${" + var_name + "}", var_value)

    @keyword(name="End Test")
    def end_test(self, data, test):
        if test.status == 'PASS':
            self.passed_tests.append(test)
        else:
            self.failed_tests.append(test)

    @keyword(name="Start Suite")
    def start_suite(self, data, suite):
        # In the execution triggers of the robot,
        # we have access to the built-in context to retrieve data.
        # Therefore, it is necessary to set the OUTPUT_DIR in each suite
        # so that we can reuse it in case of rerun.
        global OUTPUT_DIR
        OUTPUT_DIR = BuiltIn().get_variable_value("${OUTPUT_DIR}")

        self.set_global_variables(
            APP=APP,
            AUTOMATION_NAME=AUTOMATION_NAME,
            CAPTURE_EVIDENCE=CAPTURE_EVIDENCE,
            DEVICE_NAME=DEVICE_NAME,
            HEADLESS=HEADLESS,
            LOG_LEVEL=LOG_LEVEL,
            SPEED=SPEED,
            TIMEOUT=TIMEOUT,
            ORANGE_HRM_URL=ORANGE_HRM_URL,
            PLATFORM_NAME=PLATFORM_NAME,
            REMOTE_URL=REMOTE_URL,
            VIACEP_URL=VIACEP_URL
        )
