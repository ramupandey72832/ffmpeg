ffmpeg -i input.mp4 -vf "scale=-2:320" -c:v libx264 -crf 24 output.mp4
