CREATE DATABASE IF NOT EXISTS threads;
USE threads;

CREATE TABLE Users (
    UserID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    FullName VARCHAR(100),
    Bio VARCHAR(150),
    ProfilePictureURL VARCHAR(255),
    IsPrivate BOOLEAN DEFAULT FALSE,
    RegistrationDate DATETIME NOT NULL
);

CREATE TABLE Media (
    MediaID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    MediaType VARCHAR(10) NOT NULL,
    MediaURL VARCHAR(255) NOT NULL,
    UploadDate DATETIME NOT NULL
);

CREATE TABLE Post (
    PostID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    AuthorUserID INT UNSIGNED NOT NULL,
    ContentText VARCHAR(500),
    AttachmentMediaID INT UNSIGNED,
    CreationTimestamp DATETIME NOT NULL,
    LikeCount INT DEFAULT 0,
    ReplyCount INT DEFAULT 0,
    RepostCount INT DEFAULT 0,
    FOREIGN KEY (AuthorUserID) REFERENCES Users(UserID),
    FOREIGN KEY (AttachmentMediaID) REFERENCES Media(MediaID)
);

CREATE TABLE Comment (
    ReplyID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    PostID INT UNSIGNED NOT NULL,
    ReplyAuthorID INT UNSIGNED NOT NULL,
    ParentReplyID INT UNSIGNED,
    ReplyText VARCHAR(500) NOT NULL,
    CreationTimestamp DATETIME NOT NULL,
    FOREIGN KEY (PostID) REFERENCES Post(PostID),
    FOREIGN KEY (ReplyAuthorID) REFERENCES Users(UserID),
    FOREIGN KEY (ParentReplyID) REFERENCES Comment(ReplyID)
);

CREATE TABLE Follow_Link (
    FollowerID INT UNSIGNED NOT NULL,
    FollowingID INT UNSIGNED NOT NULL,
    FollowDate DATETIME NOT NULL,
    IsAccepted BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (FollowerID, FollowingID),
    FOREIGN KEY (FollowerID) REFERENCES Users(UserID),
    FOREIGN KEY (FollowingID) REFERENCES Users(UserID)
);

CREATE TABLE Likes (
    LikeID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    UserID INT UNSIGNED NOT NULL,
    PostID INT UNSIGNED NOT NULL,
    Timestamp DATETIME NOT NULL,
    UNIQUE (UserID, PostID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (PostID) REFERENCES Post(PostID)
);

INSERT INTO Users (Username, Email, PasswordHash, FullName, Bio, ProfilePictureURL, IsPrivate, RegistrationDate)
VALUES
('ivan123', 'ivan@example.com', 'hash1', 'Ivan Petrov', 'Love tech & fitness', 'https://pics.com/p1.jpg', FALSE, '2024-01-10'),
('maria', 'maria@example.com', 'hash2', 'Maria Dimitrova', 'Photographer', 'https://pics.com/p2.jpg', FALSE, '2024-02-15'),
('georgi', 'georgi@example.com', 'hash3', 'Georgi Georgiev', 'Entrepreneur', NULL, TRUE, '2024-03-20'),
('alex99', 'alex@example.com', 'hash4', 'Alex Popov', 'Music producer', 'https://pics.com/p4.jpg', FALSE, '2024-04-12'),
('niki', 'niki@example.com', 'hash5', 'Nikolay Stoyanov', 'Student & gamer', NULL, FALSE, '2024-05-03');

INSERT INTO Users (Username, Email, PasswordHash, FullName, Bio, ProfilePictureURL, IsPrivate, RegistrationDate)
VALUES
('silvia', 'silvia@example.com', 'hash6', 'Silvia Koleva', 'Digital artist', 'https://pics.com/u6.jpg', FALSE, '2024-06-01'),
('petar00', 'petar@example.com', 'hash7', 'Petar Ivanov', 'Car enthusiast', NULL, TRUE, '2024-06-10'),
('valeri', 'valeri@example.com', 'hash8', 'Valeri Stamenov', 'Travel lover', 'https://pics.com/u8.jpg', FALSE, '2024-06-15'),
('dani', 'dani@example.com', 'hash9', 'Daniela Kostova', 'Blogger', 'https://pics.com/u9.jpg', FALSE, '2024-06-20'),
('stefan', 'stefan@example.com', 'hash10', 'Stefan Hristov', 'Gym rat 💪', NULL, FALSE, '2024-06-25'),
('teo', 'teo@example.com', 'hash11', 'Teodor Pavlov', 'Software developer', 'https://pics.com/u11.jpg', TRUE, '2024-06-28'),
('mitko', 'mitko@example.com', 'hash12', 'Dimitar Yordanov', 'Movie addict', NULL, FALSE, '2024-07-01'),
('viktor', 'viktor@example.com', 'hash13', 'Viktor Marinov', 'Fitness & boxing', 'https://pics.com/u13.jpg', FALSE, '2024-07-03'),
('ani', 'ani@example.com', 'hash14', 'Ani Stoyanova', 'Cat lover 🐱', 'https://pics.com/u14.jpg', TRUE, '2024-07-04'),
('koko', 'koko@example.com', 'hash15', 'Kostadin Kolev', 'Memes everyday', NULL, FALSE, '2024-07-05');

INSERT INTO Media (MediaType, MediaURL, UploadDate)
VALUES
('image', 'https://media.com/img1.jpg', '2024-06-01'),
('image', 'https://media.com/img2.jpg', '2024-06-05'),
('video', 'https://media.com/vid1.mp4', '2024-06-07'),
('image', 'https://media.com/img3.jpg', '2024-06-10'),
('image', 'https://media.com/img4.jpg', '2024-06-13'),
('image', 'https://media.com/img5.jpg', '2024-06-16'),
('image', 'https://media.com/img6.jpg', '2024-06-17'),
('video', 'https://media.com/vid2.mp4', '2024-06-18'),
('image', 'https://media.com/img7.jpg', '2024-06-19'),
('image', 'https://media.com/img8.jpg', '2024-06-20'),
('video', 'https://media.com/vid3.mp4', '2024-06-21'),
('image', 'https://media.com/img9.jpg', '2024-06-22'),
('image', 'https://media.com/img10.jpg', '2024-06-23'),
('image', 'https://media.com/img11.jpg', '2024-06-24'),
('video', 'https://media.com/vid4.mp4', '2024-06-25');

INSERT INTO Post (AuthorUserID, ContentText, AttachmentMediaID, CreationTimestamp, LikeCount, ReplyCount, RepostCount)
VALUES
(1, 'First day on this platform!', NULL, '2024-07-01 12:00:00', 3, 1, 0),
(2, 'Just uploaded a new photoshoot 📸', 1, '2024-07-02 14:30:00', 5, 2, 1),
(3, 'Working on a new startup idea!', NULL, '2024-07-03 09:15:00', 2, 0, 0),
(4, 'Check out my latest beat 🔥', 3, '2024-07-04 16:40:00', 4, 1, 1),
(5, 'Gaming night highlights!', 4, '2024-07-05 18:00:00', 6, 2, 0),
(1, 'Replying to @maria Amazing photos!', NULL, '2024-07-02 15:00:00', 1, 0, 0);

INSERT INTO Post (AuthorUserID, ContentText, AttachmentMediaID, CreationTimestamp, LikeCount, ReplyCount, RepostCount)
VALUES
(1, 'Morning vibes ☕️✨', 5, '2024-07-08 08:12:00', 12, 3, 1),
(2, 'New portrait session coming soon!', 6, '2024-07-08 10:40:00', 21, 5, 2),
(3, 'Startup progress: prototype ready!', NULL, '2024-07-08 11:15:00', 9, 0, 0),
(4, 'Dropping a new beat tonight 🎧🔥', 7, '2024-07-08 13:00:00', 33, 4, 3),
(5, 'Ranked match win streak! 🎮', NULL, '2024-07-08 14:25:00', 18, 2, 1),
(6, 'New art sketch I made today ✍️', 8, '2024-07-08 15:30:00', 27, 6, 1),
(7, 'Car detailing level 100 😎🚗', 9, '2024-07-08 16:10:00', 14, 1, 0),
(8, 'Just landed in Paris ✈️🇫🇷', 10, '2024-07-08 17:50:00', 40, 8, 4),
(9, 'Blog update: Tips for productivity', NULL, '2024-07-08 18:30:00', 7, 0, 0),
(10, 'Leg day… send help 😭🔥', NULL, '2024-07-08 19:00:00', 25, 3, 0),
(11, 'Code compiled on first try 😳👌', NULL, '2024-07-08 19:45:00', 11, 1, 0),
(12, 'Movie review: This one shocked me 😱', 11, '2024-07-08 20:10:00', 29, 4, 2),
(13, 'Boxing session done 🥊💥', NULL, '2024-07-08 20:45:00', 35, 5, 1),
(14, 'My cat found a new hiding spot 😹', 12, '2024-07-08 21:20:00', 52, 9, 3),
(15, 'Fresh meme for your timeline 😂🔥', 13, '2024-07-08 21:55:00', 47, 6, 4);

INSERT INTO Comment (PostID, ReplyAuthorID, ParentReplyID, ReplyText, CreationTimestamp)
VALUES
(1, 2, NULL, 'Welcome Ivan!', '2024-07-01 12:10:00'),
(2, 1, NULL, 'Great shoot!', '2024-07-02 14:45:00'),
(2, 4, NULL, 'Amazing work!', '2024-07-02 14:50:00'),
(4, 5, NULL, 'Beat is fire!', '2024-07-04 17:00:00'),
(5, 3, NULL, 'Cool gameplay!', '2024-07-05 18:20:00'),
(5, 2, NULL, 'Nice highlight reel!', '2024-07-05 18:25:00'),
(7, 8, NULL, 'Looks awesome!', '2024-07-06 12:10:00'),
(8, 9, NULL, 'Italy is beautiful!', '2024-07-06 13:20:00'),
(8, 6, NULL, 'Great shot!', '2024-07-06 13:25:00'),
(8, 2, NULL, 'Love it!', '2024-07-06 13:30:00'),
(10, 11, NULL, 'Bro is huge!', '2024-07-06 15:15:00'),
(10, 3, NULL, 'Respect!', '2024-07-06 15:20:00'),
(12, 4, NULL, 'Watch Inception!', '2024-07-06 18:20:00'),
(12, 5, NULL, 'Try Interstellar!', '2024-07-06 18:25:00'),
(13, 15, NULL, 'Go champ!', '2024-07-06 19:10:00'),
(14, 1, NULL, 'So cute 😍', '2024-07-06 20:20:00'),
(14, 3, NULL, 'Awwww!', '2024-07-06 20:25:00'),
(14, 6, NULL, 'ADORABLE!', '2024-07-06 20:30:00');

INSERT INTO Follow_Link (FollowerID, FollowingID, FollowDate, IsAccepted)
VALUES
(1, 2, '2024-07-10', TRUE),
(2, 1, '2024-07-11', TRUE),
(3, 1, '2024-07-12', TRUE),
(5, 4, '2024-07-13', TRUE),
(4, 2, '2024-07-14', TRUE),
(1, 5, '2024-07-15', FALSE),
(6, 1, '2024-07-07', TRUE),
(7, 2, '2024-07-07', TRUE),
(8, 3, '2024-07-07', TRUE),
(9, 4, '2024-07-07', TRUE),
(10, 5, '2024-07-07', TRUE),
(11, 6, '2024-07-08', TRUE),
(12, 7, '2024-07-08', TRUE),
(13, 8, '2024-07-08', TRUE),
(14, 9, '2024-07-08', TRUE),
(15, 10, '2024-07-08', TRUE),
(1, 6, '2024-07-08', TRUE),
(2, 7, '2024-07-08', TRUE),
(3, 8, '2024-07-08', TRUE);

INSERT INTO Likes (UserID, PostID, Timestamp)
VALUES
(1, 2, '2024-07-02 14:35:00'),
(2, 1, '2024-07-01 12:05:00'),
(3, 1, '2024-07-01 12:06:00'),
(4, 5, '2024-07-05 18:02:00'),
(5, 5, '2024-07-05 18:04:00'),
(2, 4, '2024-07-04 16:45:00'),
(1, 5, '2024-07-05 18:06:00'),
(3, 2, '2024-07-02 14:40:00'),
(6, 7, '2024-07-06 12:02:00'),
(7, 8, '2024-07-06 13:12:00'),
(8, 10, '2024-07-06 15:05:00'),
(9, 14, '2024-07-06 20:12:00'),
(10, 14, '2024-07-06 20:15:00'),
(11, 14, '2024-07-06 20:18:00'),
(12, 15, '2024-07-06 21:05:00'),
(13, 15, '2024-07-06 21:10:00'),
(14, 15, '2024-07-06 21:12:00'),
(15, 13, '2024-07-06 19:05:00'),
(6, 8, '2024-07-06 13:40:00'),
(7, 9, '2024-07-06 14:33:00'),
(8, 11, '2024-07-06 16:30:00'),
(9, 12, '2024-07-06 18:16:00'),
(10, 13, '2024-07-06 19:02:00'),
(11, 8, '2024-07-06 13:50:00');
