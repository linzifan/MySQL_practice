USE test;

CREATE TABLE A (
Member_ID varchar(32),
Log_time date,
URL varchar(100)
);

INSERT INTO A VALUES ('001', '2015-01-01', 'www');
INSERT INTO A VALUES ('001', '2015-01-02', 'www');
INSERT INTO A VALUES ('001', '2015-01-03', 'www');
INSERT INTO A VALUES ('002', '2015-01-02', 'wwww');
INSERT INTO A VALUES ('002', '2015-01-03', 'wwww');
INSERT INTO A VALUES ('003', '2015-01-02', 'wwwww');
INSERT INTO A VALUES ('003', '2015-01-03', 'wwwww');

SELECT * FROM A;

#表A结构如下：
#Member_ID（用户的ID，字符型）
#Log_time（用户访问页面时间，日期型（只有一天的数据））
#URL（访问的页面地址，字符型）
#要求：提取出每个用户访问的第一个URL（按时间最早），形成一个新表（新表名为B，表结构和表A一致）

CREATE TABLE B AS SELECT Member_ID, min(Log_time), URL FROM A GROUP BY Member_ID;

SELECT * FROM B;