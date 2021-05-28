/* SQL inserts for sensors table */

INSERT OR IGNORE INTO sensors (sensor_id, sensor_name, units, sensor_description)
VALUES
(1, "Step counter", "steps", ""),
(2, "Stationary detect", "", ""),
(3, "Rotation vector", "rad", ""),
(4, "Proximity", "cm", ""),
(5, "Magnetic field uncalibrated", "uT", ""),
(6, "Pressure", "hPa", ""),
(7, "Motion detect", "", ""),
(8, "Step detector", "", ""),
(9, "Linear acceleration", "m/s^2", ""),
(10, "Significant motion", "", ""),
(11, "Gravity", "m/s^2", ""),
(12, "Gyroscope", "rad/s", ""),
(13, "Game rotation vector", "", ""),
(14, "Gyroscope uncalibrated", "rad/s", ""),
(15, "Light", "lux", ""),
(16, "Magnetic field", "uT", ""),
(17, "Accelerometer uncalibrated", "m/s^2", ""),
(18, "Accelerometer", "m/s^2", ""),
(19, "Heart rate", "bpm", ""),
(20, "Orientation", "deg", ""),
(21, "Location", "deg / m", "");