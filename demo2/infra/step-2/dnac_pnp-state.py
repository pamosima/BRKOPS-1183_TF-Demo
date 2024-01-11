import sys
import json
import time

from dnacentersdk import api


def main():
    try:
        dnac = api.DNACenterAPI(base_url="https://198.18.129.100", username="user1",password="C1sco12345", verify=False)
        input = sys.stdin.read()
        input_json = json.loads(input)
        
        while True:
            response = dnac.device_onboarding_pnp.get_device_list(serial_number=input_json['serial_number'])
            state = response[0]["deviceInfo"]["state"]

            if state == "Provisioned":
                result = {"state": state}
                print(json.dumps(result))
                sys.exit(0)

            time.sleep(5) 
        
    except Exception as e:
        print(e, file=sys.stderr)
        sys.exit(1) 
        
if __name__ == "__main__":
    main()