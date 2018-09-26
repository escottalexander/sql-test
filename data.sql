CREATE TABLE users (
    id serial PRIMARY KEY,
    first_name text,
    last_name text,
    email text NOT NULL,
    screen_name text NOT NULL
);

CREATE TABLE posts (
    id serial PRIMARY KEY,
    title text,
    content text,
    author_id int REFERENCES users ON DELETE RESTRICT,
    published timestamp DEFAULT now()
);

CREATE TABLE tags (
    id serial PRIMARY KEY,
    tag text NOT NULL
);


CREATE TABLE post_tags (
    post_id int REFERENCES posts(id) ON DELETE CASCADE,
    tag_id int REFERENCES tags(id) ON DELETE RESTRICT,
    PRIMARY KEY (post_id, tag_id)
);

CREATE TABLE comments (
    id serial PRIMARY KEY,
    comment_text TEXT,
    author_id int REFERENCES users ON DELETE CASCADE NOT NULL,
    post_id int REFERENCES posts ON DELETE CASCADE NOT NULL,
    referring_comment_id int,
    FOREIGN KEY (referring_comment_id) REFERENCES comments(id) ON DELETE SET NULL
);

INSERT INTO users (email, screen_name) 
VALUES ('jdoe@gmail.com', 'John_Doe'),
('jdeere@gmail.com', 'Jane_Deere'),
('skippy@gmail.com', 'PBman');

INSERT INTO tags (tag) 
VALUES ('cool'),
('coffee'),
('freebies');

INSERT INTO posts (title, content, author_id) 
VALUES ('Cool Coffee Freebies', 'Check out this website to get you free...', 1),
('Amazing things to make your hair grow', 'Egg yolks are the top...', 2),
('Seven ways to make him jealous', 'Start talking about...', 3);

INSERT INTO post_tags (post_id, tag_id) 
VALUES (1, 1),
(1, 2),
(1, 3);

INSERT INTO comments (comment_text, author_id, post_id, referring_comment_id) 
VALUES ('this post was so great. you are inspiring', 2, 1, 1),
('I say the same to all of you, my readers', 1,1,1),
('man, who would of thought you could get so much free stuff', 3, 1,1);

