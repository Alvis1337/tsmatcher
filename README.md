# Automated Media File Mover for Sonarr

This Bash script automates the process of moving media files from a torrent download folder to the appropriate series and season folder in a Sonarr library. It intelligently detects season numbers and matches series names in a case-insensitive manner.

## Features

✅ **Automatic Series Matching** – Uses fuzzy matching to locate the correct series folder in Sonarr, even if the names don’t exactly match.

✅ **Season Detection** – Extracts the season number from the torrent folder name (e.g., `S01E01` → `Season 1`) and places files in the correct `Season X` folder if it exists.

✅ **Fallback Copying** – If no season number is found, the script will copy files to the root series folder instead.

✅ **Handles Case Differences** – Works even if the series name capitalization differs between the torrent and Sonarr folders.

✅ **Batch Processing** – Processes all series folders inside the `/torrents` directory automatically.

## Installation

### **Dependencies**
- `fzf` (for fuzzy matching)
- `find`, `awk`, `sed`, and standard Unix utilities

Install `fzf` if you haven’t already:
```sh
sudo apt install fzf  # Debian/Ubuntu
brew install fzf      # macOS
```

## Usage

### **1. Place the script in a file (e.g., `move_files.sh`) and make it executable**
```sh
chmod +x move_files.sh
```

### **2. Update the script with your folder paths**
Modify these variables inside the script:
```sh
SOURCE_DIR="/torrents"
DEST_DIR="/sonarr"
```

### **3. Run the script**
```sh
./move_files.sh
```

## Example Behavior

### **Scenario 1: Season Number is Present**
#### **Before Execution**
```
/torrents/Btooom! (2012) - S01E01/
/sonarr/BTOOOM!/Season 1/
```
#### **After Execution**
```
/sonarr/BTOOOM!/Season 1/Btooom! (2012) - S01E01.mkv
```

### **Scenario 2: No Season Number**
#### **Before Execution**
```
/torrents/Land of the Lustrous (2017)/
/sonarr/Land of the Lustrous/
```
#### **After Execution**
```
/sonarr/Land of the Lustrous/Land of the Lustrous (2017).mkv
```

## Notes
- The script assumes Sonarr has already created the series folders.
- It won’t overwrite files that already exist in the destination.
- You can modify the script to support additional file types if needed.

## License
MIT License. Feel free to modify and share!

---
🚀 **Automate your media organization with ease!**

