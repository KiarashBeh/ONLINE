CREATE TABLE exercise_logs(
	id INT IDENTITY(1,1) PRIMARY KEY,
    type TEXT,
    minutes INT, 
    calories INT,
    heart_rate INT);


INSERT INTO exercise_logs(type, minutes, calories, heart_rate) VALUES ("biking", 30, 100, 110);
INSERT INTO exercise_logs(type, minutes, calories, heart_rate) VALUES ("biking", 10, 30, 105);
INSERT INTO exercise_logs(type, minutes, calories, heart_rate) VALUES ("dancing", 15, 200, 120);

SELECT * FROM exercise_logs;