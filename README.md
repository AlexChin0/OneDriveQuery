# OneDriveQuery
A simple batch script which queries a list of machines on a network and returns the status of that users OneDrive syncing. The script references a public library in c# and uses an additional powershell component to execute remotely. PSTools are used for remote scripting.

                                                 ***How it works***
Reads list of machine names (AlexC) from text file machines.txt. For each machine, filedrop.bat will
1. Check if a user is logged on using qwinsta
2. If a user is logged on, create a directory on their machine and copy odcheck.ps1 to it
3. Use PSExec to run odcheck.ps1, then write to output.txt

ODCheck.ps1 uses two public libraries (OneDrive.dll and a public c# library)
It simply imports and enables OneDrive.dll to the user machine and runs a status check, passing it's output back to FileDrop.bat for writing.

                                                  ***References***
OneDrive.dll: https://github.com/rodneyviana/ODSyncService
MurrayJu C# Code: https://github.com/murrayju/CreateProcessAsUser
