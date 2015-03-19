if [ -f Dockerfile ]
then
rm Dockerfile
fi


echo "FROM dockerfile/nodejs" >>Dockerfile
#echo "RUN apt-get update">>Dockerfile

#echo "RUN apt-get -y install libpq-dev">>Dockerfile

#echo "RUN apt-get -y install python-pip" >>Dockerfile
export
echo "copy . /$JOB_NAME" >>Dockerfile
echo "WORKDIR /$JOB_NAME" >>Dockerfile
#echo "USER daemon" >>Dockerfile
echo "RUN npm install -g grunt-cli" >>Dockerfile
echo "RUN npm install" >>Dockerfile
#echo "RUN npm install node-static" >>Dockerfile

echo "RUN grunt build " >>Dockerfile
echo "RUN wget -O /appengine.zip https://storage.googleapis.com/appengine-sdks/featured/google_appengine_1.9.18.zip" >>Dockerfile
echo "RUN unzip /appengine.zip -d /appengine">>Dockerfile
#echo "RUN pip install -r dev-requirements.txt" >>Dockerfile
#echo "RUN python setup.py install">>Dockerfile
echo "EXPOSE 8000" >>Dockerfile
#echo "WORKDIR /$JOB_NAME/examples" >>Dockerfile
echo "CMD [\"python\",\"/appengine/google_appengine/dev_appserver.py\",\"./out/app_engine\",\"--skip_sdk_update_check\"]" >>Dockerfile
JOB_NAME=$(echo $JOB_NAME | tr '[A-Z]' '[a-z]') 
docker build -t aadebuger/$JOB_NAME .
docker rm -f $JOB_NAME || echo "hello"
docker run -d  -p 12034:12034  --name $JOB_NAME aadebuger/$JOB_NAME
docker logs $JOB_NAME
