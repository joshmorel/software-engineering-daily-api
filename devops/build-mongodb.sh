#!/bin/bash

if [ -z "$MONGO_DB" ]; then
	echo "MONGO_DB environment variable must be set. This should be the database you want to download from the sedaily-mongo-backup S3 bucket."
	exit 1
fi

# download the latest backup from MongoDB
curl -Ls -O https://s3.ca-central-1.amazonaws.com/sedaily-mongo-backup2/$MONGO_DB.tar.gz

# unpack and move the dump to the right directory
rm -r dump/
tar -zxf $MONGO_DB.tar.gz
mkdir dump/
mv $MONGO_DB/* dump/
rmdir $MONGO_DB
rm $MONGO_DB.tar.gz

docker build -f mongo.Dockerfile -t softwaredaily/sedaily-mongo .

rm -r dump/

#docker push softwaredaily/sedaily-mongo
