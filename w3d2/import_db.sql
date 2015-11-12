DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Ned', 'Stark'),
  ('Tyrion', 'Lannister'),
  ('Daenerys', 'Targaryen');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('Head issues', 'What happened to my head?', 1),
  ('Wine issues', 'Where is my glass of wine?', 2),
  ('Height issues', 'How can I get taller?', 2);

INSERT INTO
  question_follows (question_id, user_id)
VALUES
  (1,2), (1,3), (2,1), (2,3);

INSERT INTO
  replies (question_id, parent_reply_id, user_id, body)
VALUES
  (1, NULL, 2, 'Ask my nephew'),
  (2, NULL, 3, 'No drinking for my advisors'),
  (2, 2, 2, 'At least I am not enslaving anyone...');

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  (1,2), (2,1), (3,2), (2,2);
