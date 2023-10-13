# Expected folder structure:

# Library
# |_ Tracks
# |_ Lossless
# |_ Zips
# |_ Artwork

set -o pipefail

bold=$(tput bold)
normal=$(tput sgr0)

getTitle() { id3tool "$1" | sed -n 's|^Song Title:\t||p'; }

# ! Set library root folder !
cd your-library-path-here

# Extract all zip archives in your library, and move to /Zips folder:
unzip ./Tracks/'*.zip' -d ./Tracks
find ./Tracks/ -type f -iname \*.zip -exec mv {} ./Zips/ \;

# Move all images to /Artwork folder:
find ./Tracks/ -type f \( -iname \*.jpg -o -iname \*.png \) -exec mv {} ./Artwork/ \;

# Convert all non-mp3 audio files to 320kbps mp3 and archive lossless files to /Lossless:
find ./Tracks/ -type f \( -iname \*.flac -o -iname \*.wav -o -iname \*.aif -o -iname \*.aiff -o -iname \*.ogg -o -iname \*.m4a \) -exec ffmpeg -n -i {} -ar 44100 -acodec libmp3lame -ab 320k {}.mp3 \;
find ./Tracks/ -type f \( -iname \*.flac -o -iname \*.wav -o -iname \*.aif -o -iname \*.aiff \) -exec mv {} ./Lossless/ \;

# Remove leftover empty folders:
find ./Tracks/*/ -type f -exec mv {} ./Tracks/ \;
find ./Tracks/ -depth -type d -empty -exec rmdir {} \;

# Ask user whether or not to delete files with unrecognised extensions:
find ./Tracks/ -not -path '*/.*' -type f -not -iname \*.mp3 -exec echo "{};" \;
echo "${bold}Files listed above are anomalies. Would you like to move them to the trash?${normal}"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) find ./Tracks/ -not -path '*/.*' -type f -not -iname \*.mp3 -exec trash {} \;
	break;;
        No ) break;;
    esac
done


