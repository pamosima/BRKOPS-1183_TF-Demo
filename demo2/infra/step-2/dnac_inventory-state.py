import sys
import json
import time

from dnacentersdk import api


def main():
    try:
        dnac = api.DNACenterAPI(base_url="https://198.18.129.100", username="user",password="password", verify=False)
        input = sys.stdin.read()
        input_json = json.loads(input)
        
        while True:
            response = dnac.devices.get_network_device_by_ip(ip_address=input_json['ip_address'])
            state = response["response"]["collectionStatus"]

            if state == "Managed":
                result = {"collectionStatus": state}
                print(json.dumps(result))
                sys.exit(0)

            time.sleep(5) 
        
    except Exception as e:
        print(e, file=sys.stderr)
        sys.exit(1) 
        
if __name__ == "__main__":
    main()