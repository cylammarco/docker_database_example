sudo docker-compose up --force-recreate --build --no-start
# DO NOT EVER USE THE PASSWORD ARGUMENT ON A PUBLIC-FACING COMPUTER

# Populate the MySQL database with the .sql
#docker start mysql_container
#docker exec -it mysql_container bash -c "mysqladmin -u root --password='0123456789' create WUMa"
#docker exec -it mysql_container bash -c "mysql -u root --password='0123456789' WUMa -e 'CREATE TABLE WUMa (MJD FLOAT, mag FLOAT, mag_err FLOAT) ENGINE=INNODB'"
#docker exec -it mysql_container bash -c "mysqlimport --ignore-lines=1 --fields-terminated-by=',' -u root --password='0123456789' WUMa /data/WUMa.csv"

docker start postgres_container
docker start mongo_container
docker exec -it mongo_container bash -c "mongo 123.0.0.4"
docker start influx_container
python csv_to_influxline.py
sleep 20

# Populate PostgreSQL with the text CSV
docker exec postgres_container bash -c "psql -U postgres -c \"CREATE DATABASE WUMa;\""
docker exec postgres_container bash -c "psql wuma -U postgres -c \"CREATE TABLE lightcurve (
  mjd float8,
  mag float8,
  mag_err float8
  );\""
docker exec postgres_container bash -c "psql wuma -U postgres -c \"COPY lightcurve from '/data/WUMa.csv' CSV HEADER;\""
docker stop postgres_container

# Populate mongoDB with the text CSV
docker exec mongo_container bash -c "mongoimport -d UWMa -c lightcurve --type csv --file /data/WUMa.csv --headerline"
docker stop mongo_container

# Populate influxDB with the text CSV
docker exec influx_container bash -c "influx -import -path=/data/WUMa.txt -precision=s"
docker stop influx_container

# Populate timescaleDB with the text CSV
#docker start timescale_container
#docker stop timescale_container
#docker start timescale_container
#docker exec timescale_container bash -c "psql -U postgres -c \"CREATE DATABASE WUMa;\""
#docker exec timescale_container bash -c "psql wuma -U postgres -c \"CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;\""
#docker exec timescale_container bash -c "psql wuma -U postgres -c \"CREATE TABLE lightcurve (
#  mjd int NOT NULL,
#  mag float8 NOT NULL,
#  mag_err float8 NOT NULL,
#  PRIMARY KEY(mjd)
#  );\""
#docker exec timescale_container bash -c "psql wuma -U postgres -c \"SELECT create_hypertable('lightcurve', 'mjd', 4);\""
#docker exec timescale_container bash -c "timescaledb-parallel-copy --db-name WUMa --table lightcurve --file /data/WUMa.csv --copy-options \"CSV\""
#docker stop timescale_container


docker-compose up