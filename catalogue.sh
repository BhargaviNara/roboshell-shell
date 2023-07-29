echo -e "\e[36m>>>>>>>>>create catalogue service<<<<<<<<<<\e[0m" /tmp/roboshop.log
cp catalogue.service /etc/systemd/system/catalogue.service
echo -e "\e[36m>>>>>>>>>create mongo repo<<<<<<<<<<\e[0m" /tmp/roboshop.log
cp mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[36m>>>>>>>>>create catalogue service<<<<<<<<<<\e[0m" /tmp/roboshop.log
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[36m>>>>>>>>install nodejs <<<<<<<<<<\e[0m" /tmp/roboshop.log

yum install nodejs -y
echo -e "\e[36m>>>>>>>>>create app user<<<<<<<<<<\e[0m" /tmp/roboshop.log
useradd roboshop
echo -e "\e[36m>>>>>>>>>create app dir<<<<<<<<<<\e[0m" /tmp/roboshop.log
mkdir /app
echo -e "\e[36m>>>>>>>>>download app content<<<<<<<<<<\e[0m"
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