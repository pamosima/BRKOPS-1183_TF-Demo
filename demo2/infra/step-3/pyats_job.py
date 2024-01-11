import subprocess
import json
import sys

def run_pyats_job(testbed_path, job_script):
    # Command to run pyats job
    command = f"pyats run job {job_script} --testbed {testbed_path}"

    try:
        # Run the command and capture the exit code
        result = subprocess.run(command, shell=True, check=False, capture_output=True, text=True)

        # Ensure that exit code is converted to string
        exit_code_str = str(result.returncode)

        # Prepare JSON response
        response = {
            "exit_code": exit_code_str,
            "stdout": result.stdout,
            "stderr": result.stderr
        }

        # Print JSON response
        print(json.dumps(response, indent=2))

    except Exception as e:
        # Handle any exceptions
        response = {
            "exit_code": "4",  # Treat all other exceptions as unknown
            "error": str(e)
        }
        print(json.dumps(response, indent=2))


if __name__ == "__main__":
    # Check if testbed_path is provided as a command-line argument
    if len(sys.argv) != 2:
        print("Usage: python script.py <testbed_path>")
        sys.exit(2)  # Incorrect command-line arguments

    # Get testbed_path from command-line argument
    testbed_path = sys.argv[1]

    # Specify the job script
    job_script = "job.py"

    # Run the pyats job and print the JSON response
    run_pyats_job(testbed_path, job_script)
