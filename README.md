## DJ Library Sort Script

This is a simple bash script I wrote to organise my music library. It will transform a messy library with various audio formats, subfolders etc. into a single /Tracks folder containing all 320kbps MP3s.

### Functionality

1. Extracts and archives all ZIP files
2. Moves artwork to a separate folder
2. Converts all audio files to 320kbps MP3
3. Archives all original lossless files
4. Asks whether or not to delete unrecognised filetypes such as text files, cache files etc.

### Dependencies

- FFmpeg
- id3tool

### Warning

- Expects an exact folder structure (see bash file)
- Please back up your library before using this script; it has only been tested on a single Mac system

### Continued Development

My intention is to build a simple GUI, allowing you to select the location of your DJ library, preferred folder structure, and preferred audio encoding.

### Known Issues

- Audio files converted by ffmpeg have double extensions, e.g. 'track.wav.mp3'. This issue does not affect functionality or compatibility

