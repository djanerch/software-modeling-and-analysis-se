CREATE DATABASE IF NOT EXISTS threads;
USE threads;

-- 1. Таблица Потребител (Users)
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

-- 2. Таблица Медия (Media)
CREATE TABLE Media (
    MediaID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    MediaType VARCHAR(10) NOT NULL,
    MediaURL VARCHAR(255) NOT NULL,
    UploadDate DATETIME NOT NULL
);

-- 3. Таблица Публикация (Post)
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

-- 4. Таблица Коментар (Comment)
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

-- 5. Таблица Следване (Follow_Link)
CREATE TABLE Follow_Link (
    FollowerID INT UNSIGNED NOT NULL,
    FollowingID INT UNSIGNED NOT NULL,
    FollowDate DATETIME NOT NULL,
    IsAccepted BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (FollowerID, FollowingID),
    FOREIGN KEY (FollowerID) REFERENCES Users(UserID),
    FOREIGN KEY (FollowingID) REFERENCES Users(UserID)
);

-- 6. Таблица Харесвания (Likes)
CREATE TABLE Likes (
    LikeID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    UserID INT UNSIGNED NOT NULL,
    PostID INT UNSIGNED NOT NULL,
    Timestamp DATETIME NOT NULL,
    UNIQUE (UserID, PostID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (PostID) REFERENCES Post(PostID)
);

--------------------------------------------------------------------------------------------------------

USE threads;

-- ========= USERS =========
INSERT INTO Users (Username, Email, PasswordHash, FullName, Bio, ProfilePictureURL, IsPrivate, RegistrationDate)
VALUES
('ivan123', 'ivan@example.com', 'hash1', 'Ivan Petrov', 'Love tech & fitness', 'https://pics.com/p1.jpg', FALSE, '2024-01-10'),
('maria', 'maria@example.com', 'hash2', 'Maria Dimitrova', 'Photographer', 'https://pics.com/p2.jpg', FALSE, '2024-02-15'),
('georgi', 'georgi@example.com', 'hash3', 'Georgi Georgiev', 'Entrepreneur', NULL, TRUE, '2024-03-20'),
('alex99', 'alex@example.com', 'hash4', 'Alex Popov', 'Music producer', 'https://pics.com/p4.jpg', FALSE, '2024-04-12'),
('niki', 'niki@example.com', 'hash5', 'Nikolay Stoyanov', 'Student & gamer', NULL, FALSE, '2024-05-03');

-- ========= MEDIA =========
INSERT INTO Media (MediaType, MediaURL, UploadDate)
VALUES
('image', 'https://media.com/img1.jpg', '2024-06-01'),
('image', 'https://media.com/img2.jpg', '2024-06-05'),
('video', 'https://media.com/vid1.mp4', '2024-06-07'),
('image', 'https://media.com/img3.jpg', '2024-06-10'),
('image', 'https://media.com/img4.jpg', '2024-06-13');

-- ========= POSTS =========
INSERT INTO Post (AuthorUserID, ContentText, AttachmentMediaID, CreationTimestamp, LikeCount, ReplyCount, RepostCount)
VALUES
(1, 'First day on this platform!', NULL, '2024-07-01 12:00:00', 3, 1, 0),
(2, 'Just uploaded a new photoshoot 📸', 1, '2024-07-02 14:30:00', 5, 2, 1),
(3, 'Working on a new startup idea!', NULL, '2024-07-03 09:15:00', 2, 0, 0),
(4, 'Check out my latest beat 🔥', 3, '2024-07-04 16:40:00', 4, 1, 1),
(5, 'Gaming night highlights!', 4, '2024-07-05 18:00:00', 6, 2, 0),
(1, 'Replying to @maria Amazing photos!', NULL, '2024-07-02 15:00:00', 1, 0, 0);

-- ========= COMMENTS =========
INSERT INTO Comment (PostID, ReplyAuthorID, ParentReplyID, ReplyText, CreationTimestamp)
VALUES
(1, 2, NULL, 'Welcome Ivan!', '2024-07-01 12:10:00'),
(2, 1, NULL, 'Great shoot!', '2024-07-02 14:45:00'),
(2, 4, NULL, 'Amazing work!', '2024-07-02 14:50:00'),
(4, 5, NULL, 'Beat is fire!', '2024-07-04 17:00:00'),
(5, 3, NULL, 'Cool gameplay!', '2024-07-05 18:20:00'),
(5, 2, NULL, 'Nice highlight reel!', '2024-07-05 18:25:00');

-- ========= FOLLOW LINKS =========
INSERT INTO Follow_Link (FollowerID, FollowingID, FollowDate, IsAccepted)
VALUES
(1, 2, '2024-07-10', TRUE),
(2, 1, '2024-07-11', TRUE),
(3, 1, '2024-07-12', TRUE),
(5, 4, '2024-07-13', TRUE),
(4, 2, '2024-07-14', TRUE),
(1, 5, '2024-07-15', FALSE);

-- ========= LIKES =========
INSERT INTO Likes (UserID, PostID, Timestamp)
VALUES
(1, 2, '2024-07-02 14:35:00'),
(2, 1, '2024-07-01 12:05:00'),
(3, 1, '2024-07-01 12:06:00'),
(4, 5, '2024-07-05 18:02:00'),
(5, 5, '2024-07-05 18:04:00'),
(2, 4, '2024-07-04 16:45:00'),
(1, 5, '2024-07-05 18:06:00'),
(3, 2, '2024-07-02 14:40:00');