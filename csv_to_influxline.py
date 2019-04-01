import pandas as pd
#convert csv's to line protocol

#convert sample data to line protocol (with nanosecond precision)
df = pd.read_csv("temp_files/raw_data/WUMa.csv")
lines = ["lightcurve"
         + " "
         + "mag=" + str(df["mag"][d]) + ","
         + "mag_err=" + str(df["mag_err"][d])
         + " " + str(int((df["MJD"][d]-40587)*86400-26)) for d in range(len(df))]
thefile = open('temp_files/raw_data/WUMa.txt', 'w+')

thefile.write("# DDL\n")
thefile.write("CREATE DATABASE WUMa\n")
thefile.write("\n")
thefile.write("# DML\n")
thefile.write("# CONTEXT-DATABASE: WUMa\n")
thefile.write("\n")
for item in lines:
    thefile.write("%s\n" % item)
