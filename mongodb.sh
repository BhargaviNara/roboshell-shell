cp mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org -y
#update listen addressfrom120.0.0. to 0.0.0.0.
systemctl enable mongod
systemctl start mongod

systemctl restart mongod