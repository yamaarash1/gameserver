DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `leader_card_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`)
);

DROP TABLE IF EXISTS `room_user`;
CREATE TABLE `room_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `select_difficulty` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `room_id` int DEFAULT NULL,
  `is_host` boolean DEFAULT FALSE,
  `is_end` boolean DEFAULT FALSE,
  `perfect` int DEFAULT NULL,
  `great` int DEFAULT NULL,
  `good` int DEFAULT NULL,
  `bad` int DEFAULT NULL,
  `miss` int DEFAULT NULL,
  `score` int DEFAULT NULL,
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `room`;
CREATE TABLE `room` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `live_id` int DEFAULT NULL,
  `joined_user_account` int DEFAULT 0,
  `max_user_count` int DEFAULT 1,
  `owner_token` varchar(255) DEFAULT NULL,
  `is_dissolution` boolean DEFAULT FALSE,
  `is_started` boolean DEFAULT FALSE,
  PRIMARY KEY (`id`)
);

INSERT INTO user(name,token,leader_card_id) VALUES ('ほのか','asdfghjkl','12345');
INSERT INTO user(name,token,leader_card_id) VALUES ('ことり','aaaa','88998');
INSERT INTO user(name,token,leader_card_id) VALUES ('うみ','qwert','173248');
INSERT INTO user(name,token,leader_card_id) VALUES ('user1','qwerta','17321');
INSERT INTO user(name,token,leader_card_id) VALUES ('user2','qwertb','17322');
INSERT INTO user(name,token,leader_card_id) VALUES ('user3','qwertc','17323');
INSERT INTO user(name,token,leader_card_id) VALUES ('user4','qwertd','17324');
INSERT INTO user(name,token,leader_card_id) VALUES ('user5','qwerte','17325');
INSERT INTO user(name,token,leader_card_id) VALUES ('user6','qwertf','17326');
INSERT INTO user(name,token,leader_card_id) VALUES ('user7','qwertg','17327');
INSERT INTO user(name,token,leader_card_id) VALUES ('user8','qwerth','17328');
INSERT INTO user(name,token,leader_card_id) VALUES ('user9','qwerti','17329');
INSERT INTO user(name,token,leader_card_id) VALUES ('user10','qwertj','173210');

INSERT INTO room(live_id,joined_user_account,max_user_count,owner_token,is_started) VALUES (1, 1, 4, 'asdfghjkl',0);
INSERT INTO room(live_id,joined_user_account,max_user_count,owner_token,is_started) VALUES (2, 1, 4, 'zxcv',1);
INSERT INTO room(live_id,joined_user_account,max_user_count,owner_token,is_started) VALUES (3, 1, 4, 'qwert',0);

INSERT INTO room_user(user_id,room_id,select_difficulty,is_host) VALUES (1, 1, 1, 1);
INSERT INTO room_user(user_id,room_id,select_difficulty,is_host,is_end,perfect,great,good,bad,miss,score) VALUES (2, 2, 1, 1, 1, 100, 10, 10, 10 ,10, 1000);
INSERT INTO room_user(user_id,room_id,select_difficulty,is_host) VALUES (3, 3, 1, 1);
INSERT INTO room_user(user_id,room_id,select_difficulty,is_host,is_end,perfect,great,good,bad,miss,score) VALUES (4, 2, 1, 0, 1, 100, 12, 11, 14 ,1, 1100);
INSERT INTO room_user(user_id,room_id,select_difficulty,is_host,is_end,perfect,great,good,bad,miss,score) VALUES (5, 2, 1, 0, 1, 101, 13, 12, 15 ,2, 1200);
INSERT INTO room_user(user_id,room_id,select_difficulty,is_host,is_end,perfect,great,good,bad,miss,score) VALUES (6, 2, 1, 0, 1, 102, 14, 15, 16 ,4, 1300);
INSERT INTO room_user(user_id,room_id,select_difficulty,is_host) VALUES (7, 1, 1, 0);
INSERT INTO room_user(user_id,room_id,select_difficulty,is_host) VALUES (8, 3, 1, 0);
INSERT INTO room_user(user_id,room_id,select_difficulty,is_host) VALUES (9, 3, 1, 0);

SELECT * FROM user;

SELECT * FROM room_user;

SELECT * FROM room;
