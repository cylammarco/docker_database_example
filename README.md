# docker_database_example

Python package `Pandas` is required to convert the CSV file into influx-ingestable format.

Add user permission to execute the shell script
`chmod +x setup.sh`

Run the script and everything should get set up
`./setup.sh`

## Example CSV data

First three rows of the example CSV file of the WUMa lightcurve.

| **MJD**       | **mag** | **mag_err** |
| :---          | :---:   | :---:       |
| 54895.9140393 | 7.96487 | 0.02167     |
| 54895.9147453 | 8.02967 | 0.02244     |
| 54895.9154282 | 7.99677 | 0.02273     |

## Currently setup

| **Database** | **ip address** | **port** |
| :---         | :---:          | :---:    |
| PostgreSQL   | 123.0.0.3      | 22002    |
| MongoDB      | 123.0.0.4      | 22003    |
| InfluxDB     | 123.0.0.5      | 22004    |

## To do

| **Database** | **ip address** | **port** |
| :---         | :---:          | :---:    |
| MySQL        | 123.0.0.2      | 22001    |
| TimescaleDB  | 123.0.0.6      | 22005    |
| kdb          | 123.0.0.7      | 22006    |
