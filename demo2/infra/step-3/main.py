from pyats import aetest
from genie import testbed

class CommonSetup(aetest.CommonSetup):
    
    @aetest.subsection
    def connect(self, testbed):
        for device in testbed:
            device.connect()
    
class Testcase(aetest.Testcase):
    @aetest.test
    def vrf(self, testbed, steps):
        for device_name in testbed.devices:
            device = testbed.devices[device_name]
            vrfs = "Campus_VN", "Guest_VN"         
            for vrf in vrfs:
                with steps.start(f"Testing VRF {vrf} on device {device_name}", continue_=True) as step_vrf:
                    try:
                        device.parse(f"show vrf {vrf}")
                        step_vrf.passed(f"VRF {vrf} configured")
                    except Exception as e:
                        step_vrf.failed(f"VRF {vrf} not configured") 

class CommonCleanup(aetest.CommonCleanup):
    
    @aetest.subsection
    def disconnect(self,testbed):
        for device in testbed:
            device.disconnect()        

if __name__ == "__main__":
    devices = testbed.load("testbed.yml")
    aetest.main(testbed=devices)