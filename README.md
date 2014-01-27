### UPLOAD TO HP CLOUD
scp -i ~/.ssh/signup4good.pem signup4good.tar.gz ubuntu@15.126.212.78:~/

### LOG INTO HP CLOUD
ssh -i ~/.ssh/signup4good.pem ubuntu@15.126.212.78

### START PROCESS
`sudo ROOT_URL=http://15.126.212.78 PORT=80 MONGO_URL=mongodb://localhost:27017/myapp node ~/bundle/main.js`

event pages have broken image and weird well