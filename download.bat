@echo off
set /p url=Enter YouTube URL: 
yt-dlp -f bestvideo+bestaudio %url%
pause