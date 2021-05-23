/* SQL script to build the database schema */


/* sensor table stores all the information about various sensors */
CREATE TABLE IF NOT EXISTS sensors (
    sensor_id INT PRIMARY KEY,
    sensor_name VARCHAR(25) NOT NULL,
    units VARCHAR(10) NOT NULL,
    sensor_description VARCHAR(250)
);

/* users table keeps track of user using this service 
 In future this table can also save login / demographic information */
CREATE TABLE IF NOT EXISTS users (
    uuid VARCHAR(36) PRIMARY KEY
);

/* table to store time data as UNIX values
UNIX values calculate seconds from 01-01-1970 in UTC +0 */
CREATE TABLE IF NOT EXISTS timeDetails (
    timeID PRIMARY KEY,
    time_stamp INT NOT NULL,
    sensor_id INT,
    uuid INT,
    FOREIGN KEY (sensor_id) REFERENCES sensors(sensor_id),
    FOREIGN KEY (uuid) REFERENCES users(uuid) 
);

/* table to count number of steps */
CREATE TABLE IF NOT EXISTS stepCounter (
    number_of_steps INT,
    timeID,
    FOREIGN KEY (timeID) REFERENCES timeDetails(timeID)
);

/* table to store stationary detected values
stationary */
CREATE TABLE IF NOT EXISTS stationaryDetect (
    stationary INT,
    timeID,
    FOREIGN KEY (timeID) REFERENCES timeDetails(timeID)
);

/* table to store rotation vector 
x_axis
y_axis
z_axis 
w_axis
EHA: rad
need to figure out the units */
CREATE TABLE IF NOT EXISTS rotationVector (
    x_axis FLOAT,
    y_axis FLOAT,
    z_axis FLOAT,
    w_axis FLOAT,
    EHA FLOAT,
    timeID,
    FOREIGN KEY (timeID) REFERENCES timeDetails(timeID)
);

/* table to store proximity data 
proximity_dist: cm */
CREATE TABLE IF NOT EXISTS proximity (
    proximity_dist FLOAT,
    timeID,
    FOREIGN KEY (timeID) REFERENCES timeDetails(timeID)
);

/* table to store uncalibrated magnetoc field data
x_axis: uT
y_axis: uT
z_axis: uT
xb_axis: uT
yb_axis: uT
zb_axis: uT */
CREATE TABLE IF NOT EXISTS magneticFieldUncalibrated (
    x_axis FLOAT,
    y_axis FLOAT,
    z_axis FLOAT,
    xb_axis FLOAT,
    yb_axis FLOAT,
    zb_axis FLOAT,
    timeID,
    FOREIGN KEY (timeID) REFERENCES timeDetails(timeID)
);

/* table to store preasure applied on the phone 
preasure_applied: hPa*/
CREATE TABLE IF NOT EXISTS pressure (
    pressure_applied FLOAT,
    timeID,
    FOREIGN KEY (timeID) REFERENCES timeDetails(timeID)
);

/* table to store motion detection*/
CREATE TABLE IF NOT EXISTS motionDetect (
    motion_detection FLOAT,
    timeID,
    FOREIGN KEY (timeID) REFERENCES timeDetails(timeID)
);

/* table to store step detection data*/
CREATE TABLE IF NOT EXISTS stepDetector (
    step_detection FLOAT,
    timeID,
    FOREIGN KEY (timeID) REFERENCES timeDetails(timeID)
);

/* table to store linear acceleration
x_axis: m/s^2
y_axis: m/s^2
z_axis: m/s^2 */
CREATE TABLE IF NOT EXISTS linearAcceleration (
    x_axis FLOAT,
    y_axis FLOAT,
    z_axis FLOAT,
    timeID,
    FOREIGN KEY (timeID) REFERENCES timeDetails(timeID)
);

/* table to store significant motion*/
CREATE TABLE IF NOT EXISTS significantMotion (
    significant_motion FLOAT,
    timeID,
    FOREIGN KEY (timeID) REFERENCES timeDetails(timeID)
);

/* table to store gravity values
x_axis: m/s^2
y_axis: m/s^2
z_axis: m/s^2 */
CREATE TABLE IF NOT EXISTS gravity (
    x_axis FLOAT,
    y_axis FLOAT,
    z_axis FLOAT,
    timeID,
    FOREIGN KEY (timeID) REFERENCES timeDetails(timeID)
);

/* table to store Gyroscope data
x_axis: rad/s
y_axis: rad/s
z_axis: rad/s */
CREATE TABLE IF NOT EXISTS gyroscope (
    x_axis FLOAT,
    y_axis FLOAT,
    z_axis FLOAT,
    timeID,
    FOREIGN KEY (timeID) REFERENCES timeDetails(timeID)
);

/* table to store game rotation vector
x_axis: deg ? need to check
y_axis: deg
z_axis: deg */
CREATE TABLE IF NOT EXISTS gameRotationVector (
    x_axis FLOAT,
    y_axis FLOAT,
    z_axis FLOAT,
    timeID,
    FOREIGN KEY (timeID) REFERENCES timeDetails(timeID)
);


/* table to store incalibrated Gyroscope data 
x_axis: rad/s
y_axis: rad/s
z_axis: rad/s
xd_axis: rad/s
yd_axis: rad/s
zd_axis: rad/s */
CREATE TABLE IF NOT EXISTS gyroscopeUncalibrated (
    x_axis FLOAT,
    y_axis FLOAT,
    z_axis FLOAT,
    xd_axis FLOAT,
    yd_axis FLOAT,
    zd_axis FLOAT,
    timeID,
    FOREIGN KEY (timeID) REFERENCES timeDetails(timeID)
);

/* tabel to store lux recieved to the light sensor 
light_lux: lux */
CREATE TABLE IF NOT EXISTS light (
    light_lux FLOAT,
    timeID,
    FOREIGN KEY (timeID) REFERENCES timeDetails(timeID)
);

/* table to store magnetic field data
x_axis: uT
y_axis: uT
z_axis: uT */
CREATE TABLE IF NOT EXISTS magneticField (
    x_axis FLOAT,
    y_axis FLOAT,
    z_axis FLOAT,
    timeID,
    FOREIGN KEY (timeID) REFERENCES timeDetails(timeID)
);

/* table for uncalibrated accelerometer data
x_axis: m / s^2
y_axis: m / s^2
z_axis: m / s^2
xc_axis: m / s^2
yc_axis: m / s^2
zc_axis: m / s^2 */
CREATE TABLE IF NOT EXISTS accelerometerUncalibrated (
    x_axis FLOAT,
    y_axis FLOAT,
    z_axis FLOAT,
    xc_axis FLOAT,
    yc_axis FLOAT,
    zc_axis FLOAT,
    timeID,
    FOREIGN KEY (timeID) REFERENCES timeDetails(timeID)
);

/* table for accelerometer data
x_axis: m / s^2
y_axis: m / s^2
z_axis: m / s^2 */
CREATE TABLE IF NOT EXISTS accelerometer (
    x_axis FLOAT,
    y_axis FLOAT,
    z_axis FLOAT,
    timeID,
    FOREIGN KEY (timeID) REFERENCES timeDetails(timeID)
);

/* heart rate monitor data
heart rate: BPM */
CREATE TABLE IF NOT EXISTS heartRate (
    heart_rate FLOAT,
    timeID,
    FOREIGN KEY (timeID) REFERENCES timeDetails(timeID)
);

/* table for orientation data
azimuth: deg
pitch: deg
roll: deg */
CREATE TABLE IF NOT EXISTS orientation (
    azimuth FLOAT,
    pitch FLOAT,
    roll FLOAT,
    timeID,
    FOREIGN KEY (timeID) REFERENCES timeDetails(timeID)
);

/* table for location co-ordinates
 latitude: deg
 longitude: deg
 altitude: m */
CREATE TABLE IF NOT EXISTS locations (
    latitude FLOAT,
    longitude FLOAT,
    altitude FLOAT,
    timeID,
    FOREIGN KEY (timeID) REFERENCES timeDetails(timeID)
);