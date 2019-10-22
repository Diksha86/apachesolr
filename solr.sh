sudo apt install default-java
sudo apt-get install wget -y
sudo wget http://www-eu.apache.org/dist/lucene/solr/8.2.0/solr-8.2.0.tgz
tar xzf solr-8.2.0.tgz solr-8.2.0/bin/install_solr_service.sh --strip-components=2
sudo sudo bash ./install_solr_service.sh solr-8.2.0.tgz
sudo systemctl start solr
sudo systemctl status solr
sudo su - solr -c "/opt/solr/bin/solr create -c mycol1 -n data_driven_schema_configs"
