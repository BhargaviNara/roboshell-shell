echo ">>>>>>>>>create catalogue service<<<<<<<<<<"
cp catalogue.service /etc/systemd/system/catalogue.service
echo ">>>>>>>>>create mongo repo<<<<<<<<<<"
cp mongo.repo /etc/yum.repos.d/mongo.repo
echo ">>>>>>>>>create catalogue service<<<<<<<<<<"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo ">>>>>>>>install nodejs <<<<<<<<<<"
yum install nodejs -y
echo ">>>>>>>>>create app user<<<<<<<<<<"
useradd roboshop
echo ">>>>>>>>>create app dir<<<<<<<<<<"
mkdir /app
echo ">>>>>>>>>download app content<<<<<<<<<<"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
echo ">>>>>>>>>extract app content<<<<<<<<<"
cd /app
unzip /tmp/catalogue.zip
cd /app
echo ">>>>>>>>>install nodejs dependencies<<<<<<<<<"
npm install
echo ">>>>>>>>>install mongo client<<<<<<<<<"
yum install mongodb-org-shell -y
echo ">>>>>>>>>load catalogue schema<<<<<<<<<"
mongo --host monodb.bdevops74.online </app/schema/catalogue.js
echo ">>>>>>>>>start catalogue service<<<<<<<<<"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue