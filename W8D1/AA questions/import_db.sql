PRAGMA foreign_keys = ON;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname VARCHAR(255),
    lname VARCHAR(255)
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,
    FOREIGN KEY(author_id) REFERENCES users(id)
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    body TEXT NOT NULL,
    question_id INTEGER NOT NULL,
    parent_reply_id INTEGER,
    author_id INTEGER NOT NULL,
    FOREIGN KEY(parent_reply_id) REFERENCES replies(id),
    FOREIGN KEY(question_id) REFERENCES questions(id),
    FOREIGN KEY(author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(question_id) REFERENCES questions(id)
);

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    liker_id INTEGER NOT NULL,
    FOREIGN KEY(question_id) REFERENCES questions(id),
    FOREIGN KEY(liker_id) REFERENCES users(id)
);
  
INSERT INTO 
    users (fname,lname)
VALUES
    ('campbell','oleson'),
    ('anthony','chan');

INSERT INTO
    questions (title, body, author_id)
VALUES 
    ('how to code?','how do I code???', (SELECT 
                                            id
                                        FROM 
                                            users
                                        WHERE 
                                            users.fname = 'campbell'
                                        )
    );

INSERT INTO 
    question_follows (user_id,question_id)
VALUES
((SELECT id FROM users WHERE users.fname = 'campbell'),
(SELECT id FROM questions WHERE questions.title = 'how to code?'));

INSERT INTO 
    replies(body, question_id, parent_reply_id, author_id)
VALUES
    ('This is a good question', 
    (SELECT id FROM questions WHERE questions.title = 'how to code?'),
    NULL,
    (SELECT id FROM users WHERE users.fname = 'anthony')
    );

INSERT INTO
    question_likes(question_id, liker_id)
VALUES
    (
        (SELECT id FROM questions WHERE questions.title = 'how to code?'),
        (SELECT id FROM users WHERE users.fname = 'anthony')
    );



