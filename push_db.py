import subprocess, sys

adb = r"D:\AndroidSDK\platform-tools\adb.exe"
db_path = r"D:\flutter_projects\DueMateSmartReminder\duemate_seed.sqlite"

with open(db_path, "rb") as f:
    data = f.read()

proc = subprocess.Popen(
    [adb, "-s", "emulator-5554", "shell",
     "run-as com.duemate.smartreminder dd of=app_flutter/duemate.sqlite"],
    stdin=subprocess.PIPE,
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE
)
stdout, stderr = proc.communicate(input=data)
print("stdout:", stdout.decode(errors="replace"))
print("stderr:", stderr.decode(errors="replace"))
print("Return code:", proc.returncode)
